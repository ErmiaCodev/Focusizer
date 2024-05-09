// The callback function should always be a top-level function.
import 'dart:async';
import 'dart:isolate';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class WakeOption {
  final int duration;
  final int remaining;

  const WakeOption({
    required this.duration,
    required this.remaining,
  });
}

@pragma('vm:entry-point')
void startCallback() {
  // The setTaskHandler function must be called to handle the task in the background.
  // FlutterForegroundTask.stopService();
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyTaskHandler extends TaskHandler {
  SendPort? _sendPort;
  int _seconds = 0;
  int _duration = 0;
  bool _running = true;

  // Called when the task is started.
  @override
  void onStart(DateTime timestamp, SendPort? sendPort) async {
    _sendPort = sendPort;

    // You can use the getData function to get the stored data.
    final duration =
        await FlutterForegroundTask.getData<String>(key: 'duration');

    var mins = int.parse(await duration.toString());
    _seconds = mins * 60;
    _duration = mins;

    Timer(Duration(minutes: mins), () async {
      _running = false;
      _sendPort?.send('onFinished');
    });

    Timer(Duration(minutes: mins, milliseconds: 50), () async {
      await FlutterForegroundTask.stopService();
    });
  }

  // Called every [interval] milliseconds in [ForegroundTaskOptions].
  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    if (_seconds == 0) {
      FlutterForegroundTask.stopService();
      return;
    }

    var minutes = _seconds ~/ 60;
    var pureSec = _seconds - (minutes * 60);
    FlutterForegroundTask.updateService(
      notificationTitle: 'Focusing',
      notificationText:
          'Remaining:  $minutes:${pureSec.toString().padLeft(2, '0')}',
    );

    sendPort?.send(_seconds);

    _seconds--;
  }

  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) async {
    _sendPort?.send('onDestroy');
    _running = false;
  }

  @override
  Future<void> onNotificationButtonPressed(String id) async {
    if (id == "cancelButton") {
      _sendPort?.send('onCanceled');
      _running = false;
      Timer(const Duration(milliseconds: 200), () async {
        await FlutterForegroundTask.stopService();
      });
    }
    print('onNotificationButtonPressed >> $id');
  }

  @override
  void onNotificationPressed() {
    if (_running) {
      FlutterForegroundTask.launchApp("/");
      // _sendPort?.send(WakeOption(duration: _duration, remaining: _seconds));
    }
  }
}
