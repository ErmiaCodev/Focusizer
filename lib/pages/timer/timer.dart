import 'dart:io';
import 'dart:isolate';

import 'package:hive_flutter/adapters.dart';
import 'package:quickalert/quickalert.dart';
import '/components/actions/coins_btn.dart';
import '/components/actions/theme_toggle.dart';
import '/pages/timer/notifications/success.dart' as success;
import '/pages/timer/player/music_player.dart';
import '/components/appbar/navbar.dart';
import '/components/button/circle_btn.dart';
import '/constants/db.dart';
import '/constants/timer.dart';
import '/models/task.dart';
import '/pages/timer/infoer/infoer.dart';
import '/pages/timer/tools/toolbar.dart';
import '/styles/global.dart';

import './progress/progress.dart';
import './selector/selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'service.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({
    super.key,
  });

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int? _remaining;
  int _duration = 5;
  bool _isRunning = false;
  ReceivePort? _receivePort;
  String _title = "";
  String? _topic;
  ValueNotifier<bool> _deepFocus = ValueNotifier(false);

  Future<void> _requestPermissionForAndroid() async {
    if (!Platform.isAndroid) {
      return;
    }

    if (!await FlutterForegroundTask.canDrawOverlays) {
      await FlutterForegroundTask.openSystemAlertWindowSettings();
    }

    if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
      await FlutterForegroundTask.requestIgnoreBatteryOptimization();
    }

    final NotificationPermission notificationPermissionStatus =
        await FlutterForegroundTask.checkNotificationPermission();
    if (notificationPermissionStatus != NotificationPermission.granted) {
      await FlutterForegroundTask.requestNotificationPermission();
    }
  }

  void _initForegroundTask() {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        foregroundServiceType: AndroidForegroundServiceType.DATA_SYNC,
        channelId: 'foreground_service',
        channelName: 'Focusing',
        channelDescription:
            'This notification appears when the foreground service is running.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.HIGH,
        visibility: NotificationVisibility.VISIBILITY_PUBLIC,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
          backgroundColor: Colors.teal,
        ),
        buttons: [
          const NotificationButton(
            id: 'cancelButton',
            text: 'Cancel',
            textColor: Colors.teal,
          ),
        ],
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 1000,
        isOnceEvent: false,
        autoRunOnBoot: false,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  Future<bool> _startForegroundTask() async {
    print("Duration: ${_duration}");

    setState(() {
      _remaining = _duration * 60;
      _isRunning = true;
    });
    // You can save data using the saveData function.
    await FlutterForegroundTask.saveData(key: 'duration', value: "$_duration");
    await FlutterForegroundTask.saveData(
        key: 'deepFocus', value: _deepFocus.value.toString());

    // Register the receivePort before starting the service.
    final ReceivePort? receivePort = FlutterForegroundTask.receivePort;
    final bool isRegistered = _registerReceivePort(receivePort);
    if (!isRegistered) {
      print('Failed to register receivePort!');
      return false;
    }

    if (await FlutterForegroundTask.isRunningService) {
      return FlutterForegroundTask.stopService();
    } else {
      return FlutterForegroundTask.startService(
        notificationTitle: 'Focusing',
        notificationText: 'Tap to return to the app',
        callback: startCallback,
      );
    }
  }

  Future<bool> _stopForegroundTask() {
    setState(() {
      _isRunning = false;
    });

    return FlutterForegroundTask.stopService();
  }

  bool _registerReceivePort(ReceivePort? newReceivePort) {
    if (newReceivePort == null) {
      return false;
    }

    _closeReceivePort();

    _receivePort = newReceivePort;
    _receivePort?.listen((data) {
      if (data is int) {
        if (data > 0) {
          setState(() {
            _isRunning = (data > 0) ? true : false;
            _remaining = data;
          });
        } else {
          _resetTask();
        }
      } else if (data is String) {
        if (data == 'onNotificationPressed') {
          Navigator.of(context).pushNamed('/');
        } else if (data == "onCanceled") {
          _cancelService(context, true);
        } else if (data == "onFinished") {
          FlutterForegroundTask.stopService();
          setState(() => _isRunning = false);
          _onFinished();
        } else if (data == "onDestroy") {
          FlutterForegroundTask.stopService();
          setState(() {
            _isRunning = false;
          });
        }
      } else if (data is WakeOption) {
        setState(() {
          _remaining = data.remaining;
          _isRunning = data.remaining > 0 ? true : false;
        });
      }
    });

    return _receivePort != null;
  }

  void _closeReceivePort() {
    _receivePort?.close();
    _receivePort = null;
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _requestPermissionForAndroid();
      _initForegroundTask();

      if (await FlutterForegroundTask.isRunningService) {
        final newReceivePort = FlutterForegroundTask.receivePort;
        _registerReceivePort(newReceivePort);
      }
    });
  }

  @override
  void dispose() {
    _closeReceivePort();
    super.dispose();
  }

  Future<void> _onFinished() async {
    await success.showSuccessNotification();


    await QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: "تبریک",
        text: 'شما یک پروسه رو با موفقیت به اتمام رساندید!!',
        confirmBtnText: "تایید",
        confirmBtnColor: Colors.green.shade300);
    _saveTask();
  }

  Future<void> _addCoins() async {
    var box = await Hive.box(coinsBoxName);
    final current = box.get('coins') ?? 0;

    if (_deepFocus.value) {
      final newCoins = 4 + (6 * (_duration ~/ 5));
      box.put('coins', current + newCoins);
    } else {
      final newCoins = 4 + (2 * (_duration ~/ 5));
      box.put('coins', current + newCoins);
    }
  }

  Future<void> _decCoins() async {
    var box = await Hive.box(coinsBoxName);
    final current = box.get('coins') ?? 0;
    if (current != 0) {
      box.put('coins', current - 1);
    }
  }

  void _saveTask() {
    Box<Task> tasksBox = Hive.box<Task>(tasksBoxName);
    tasksBox.add(Task(
        name: (_title == "") ? "پروسه جدید" : _title,
        topic: _topic,
        date: DateTime.now().subtract(Duration(minutes: _duration)),
        duration: _duration));
    _addCoins();

    if (ModalRoute.of(context)?.settings.name != "/timer") {
      Navigator.popUntil(context, ModalRoute.withName('/timer'));
    }
  }

  Future<void> _cancelService(BuildContext context, bool fine) async {
    FlutterForegroundTask.stopService();
    setState(() => _isRunning = false);
    if (fine) {
      await _decCoins();
    }
  }

  Future<void> _onCanceled(BuildContext context) async {
    if ((_duration * 60) - _remaining! < max_safe_secs) {
      await _cancelService(context, false);
      _resetTask();
      return;
    }

    await QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: "اخطار",
      text: 'با این کار 1 سکه از دست خواهید داد!',
      confirmBtnText: "توقف",
      confirmBtnColor: Colors.red.shade300,
      onConfirmBtnTap: () {
        _cancelService(context, true);
        Navigator.of(context).pop();
      },
    );
  }

  void _resetTask() {
    setState(() {
      _title = "";
      _topic = null;
      _duration = 5;
      _isRunning = false;
    });
  }

  Widget _buildCtrl(BuildContext context) {
    if (_isRunning && ((_duration * 60) - _remaining!) < max_safe_secs) {
      return CircleButton(
        bgColor: Colors.amber.shade300,
        color: Colors.grey.shade600,
        callback: () => _onCanceled(context),
        icon: Icons.stop,
      );
    }

    if (_isRunning) {
      return CircleButton(
        bgColor: Colors.red.shade300,
        color: Colors.white,
        callback: () => _onCanceled(context),
        icon: Icons.stop,
      );
    }

    if (_duration == 0) {
      return CircleButton(
        bgColor: Colors.blueGrey.shade400,
        color: Colors.white,
        callback: () {},
        icon: Icons.play_arrow,
      );
    }

    return CircleButton(
      bgColor: Colors.green.shade300,
      color: Colors.white,
      callback: () => _startClicked(),
      icon: Icons.play_arrow,
    );
  }

  Future<void> showSettingsPanelModal() async {
    if (_isRunning) {
      return;
    }

    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("تنظیمات پروسه",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              content: ValueListenableBuilder<bool>(
                valueListenable: _deepFocus,
                builder: (context, currentState, child) {
                  return Container(
                    height: 200,
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.local_fire_department),
                                    SizedBox(width: 4),
                                    Text("تمرکز عمیق",
                                        style:
                                            titleStyle.copyWith(fontSize: 18),
                                        textAlign: TextAlign.end),
                                  ]),
                              Text("+ 10 سکه هدیه",
                                  style: labelStyle.copyWith(fontSize: 12),
                                  textAlign: TextAlign.end),
                            ],
                          ),
                          Switch(
                              activeColor: Colors.green.shade400,
                              value: currentState,
                              onChanged: (value) {
                                setState(() {
                                  _deepFocus.value = value;
                                });
                              })
                        ],
                      ),
                      Divider()
                    ]),
                  );
                },
              ));
        });
  }

  Widget _buildSettingsPanel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith((states) =>
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4)),
          ),
          onPressed: () => showSettingsPanelModal(),
          child: IntrinsicHeight(
            child: Row(
              children: <Widget>[
                ValueListenableBuilder<bool>(
                  valueListenable: _deepFocus,
                  builder: (context, value, child) {
                    return Icon((value == true)
                        ? Icons.local_fire_department
                        : Icons.do_not_disturb_on);
                  },
                ),
                const VerticalDivider(thickness: 2),
                const Icon(Icons.timer),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WithForegroundTask(
      child: PopScope(
        canPop: !_isRunning,
        onPopInvoked: (didPop) {
          if (_isRunning) {
            const snackBar = SnackBar(
              content: Text('تمرکزتو بهم نزن!!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.teal,
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("میز    تمر کز", style: appbarTitle),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: Theme.of(context).brightness == Brightness.dark
                    ? darkGradient
                    : brandGradient,
              ),
            ),
            foregroundColor: Colors.white,
            leading: (_isRunning) ? const MusicPlayer() : null,
            actions: const [
              CoinsBtn(open: false),
              ThemeToggler(),
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListBody(
                children: [
                  _buildSettingsPanel(),
                  const SizedBox(height: 20),
                  (!_isRunning)
                      ? TimeSelector(
                          callback: (value) {
                            setState(() {
                              _duration = value;
                            });
                          },
                        )
                      : ProgressSlider(rem: _remaining, dur: _duration),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Infoer(
                        givenTitle: _title,
                        onChange: (title, topic) {
                          setState(() {
                            _title = title;
                            _topic = topic;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          bottomNavigationBar: Container(
            height: 85,
            padding: EdgeInsets.all(0),
            // clipBehavior: Clip.antiAlias,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 60,
                    color: (Theme.of(context).brightness == Brightness.dark)
                        ? Colors.blueGrey.shade700
                        : Colors.teal.shade50,
                  ),
                ),
                Positioned(
                  top: 0,
                  child: _buildCtrl(context),
                ),
                const ToolBar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startClicked() {
    if (_duration > 0) {
      _startForegroundTask();
    }
  }
}
