import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sessions/_services/hive/local_storage_service.dart';
import 'package:sessions/_variables/common_variables.dart';

class PomodoroProvider with ChangeNotifier {
  //
  //
  //
  // user settings for pomodoro
  Map<String, String> pomodoroMap = globalBox.get('pomodoroMap', defaultValue: defaultPomodoroMap);

  void updatePomodorMap(Map<String, String> newMap) {
    pomodoroMap = newMap;
    globalBox.put('pomodoroMap', newMap);
    notifyListeners();
  }

  //
  //
  //
  // Actual timer, counts every second
  Timer? counter;

  void updateCounter(Timer timer) {
    counter = timer;
    notifyListeners();
  }

  void cancelCounter() {
    if (counter != null && counter!.isActive) {
      counter!.cancel();
    }
    notifyListeners();
  }

  //
  //
  //
  // current timer running
  String currentTimer = 'none';
  // if the timer is paused
  bool isPaused = false;

  void updateCurrentTimer(String type) {
    currentTimer = type;
    notifyListeners();
  }

  void updateIsPaused(bool value) {
    isPaused = value;
    notifyListeners();
  }

  void resetAllTimers() {
    currentTimer = 'none';
    isPaused = false;
    remainingTimeBreak = 0;
    remainingTimeFocus = 0;
    remainingTimeLongBreak = 0;
    cancelCounter();
    notifyListeners();
  }

  //
  //
  //
  // the remaining time in seconds for each timer
  int remainingTimeFocus = 0;
  int remainingTimeBreak = 0;
  int remainingTimeLongBreak = 0;

  void updateRemainingTime(String type, int seconds) {
    if (type == 'focus') {
      remainingTimeFocus = seconds;
    }
    if (type == 'break') {
      remainingTimeBreak = seconds;
    }
    if (type == 'longBreak') {
      remainingTimeLongBreak = seconds;
    }
    notifyListeners();
  }

  //
  //
  //
  // the time the current timer has started counting
  DateTime start = DateTime.now();
  // the time the current timer will stop counting
  DateTime end = DateTime.now();

  void updateStartStop(Duration timer) {
    start = DateTime.now();
    end = start.add(Duration(seconds: timer.inSeconds));
    notifyListeners();
  }
  //
  //
  //

  int timerLoops = 0;

  void updateTimerLoops() {
    timerLoops = timerLoops + 1;
    if (timerLoops == (int.parse(pomodoroMap['longBreakInterval'] ?? '4') + 1)) {
      timerLoops = 0;
    }
    notifyListeners();
  }

  //
  //
  //
}
