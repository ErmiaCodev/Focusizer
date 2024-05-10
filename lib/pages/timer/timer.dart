import 'dart:io';
import 'dart:isolate';

import 'package:hive_flutter/adapters.dart';
import 'package:taskizer/components/appbar/navbar.dart';
import 'package:taskizer/constants/db.dart';
import 'package:taskizer/models/task.dart';
import 'package:taskizer/pages/timer/infoer/infoer.dart';
import 'package:taskizer/pages/timer/tools/notes_tool.dart';
import 'package:taskizer/styles/global.dart';

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
        priority: NotificationPriority.LOW,
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
        autoRunOnBoot: true,
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
    await FlutterForegroundTask.saveData(
        key: 'duration', value: "${_duration}");

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

          FlutterForegroundTask.stopService();
          setState(() => _isRunning = false);
          _onCanceled();

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

      // You can get the previous ReceivePort without restarting the service.
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
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('تبریک!!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('شما یک پروسه را با تمرکز به پایان رساندید!',
                    style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          actions: <Widget>[
            FloatingActionButton.extended(
              backgroundColor: Colors.teal.shade300,
              foregroundColor: Colors.white,
              label: const Text('بستن!', style: labelStyle),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    _saveTask();
  }

  void _saveTask() {
    Box<Task> tasksBox = Hive.box<Task>(tasksBoxName);
    tasksBox.add(Task(
        name: _title,
        topic: _topic,
        date: DateTime.now(),
        duration: _duration));
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  void _onCanceled() {

    print(_duration);
    print("on Canceled");
  }

  void _resetTask() {
    setState(() {
      _remaining = 0;
      _isRunning = false;
    });
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.teal,
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Scaffold(
            appBar: Navbar("میز  تمرکز"),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ListBody(
                  children: [
                    (!_isRunning)
                        ? TimeSelector(
                            callback: (value) {
                              setState(() {
                                _duration = value;
                              });
                            },
                          )
                        : ProgressSlider(rem: _remaining, max: _duration * 60),
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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildContentView(),
                      ],
                    )
                  ],
                )
              ],
            ),
            bottomNavigationBar: Container(
              height: 80,
              color: Colors.teal.shade50,
              padding: EdgeInsets.all(0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NotesTool(),
                  TextButton(
                      onPressed: () {},
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.note_add),
                          Text("ماشین حساب", style: TextStyle(fontSize: 14)),
                        ],
                      )),
                ],
              ),
            )),
      ),
    );
  }

  void _startClicked() {
    if (_duration > 0) {
      _startForegroundTask();
    }
  }

  Widget _buildContentView() {
    buttonBuilder(String text, Color bgColor, {VoidCallback? onPressed}) {
      return FloatingActionButton.extended(
        backgroundColor: bgColor,
        foregroundColor: Colors.white,
        onPressed: onPressed,
        label: Text(text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (!_isRunning)
              ? ((_duration > 0 && _title != "" && _topic != null)
                  ? buttonBuilder('شروع!', Colors.teal.shade300,
                      onPressed: _startClicked)
                  : const Text(""))
              : buttonBuilder('توقف', Colors.red.shade300,
                  onPressed: _stopForegroundTask),
        ],
      ),
    );
  }
}
