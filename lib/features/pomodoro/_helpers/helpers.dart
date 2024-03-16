import 'dart:async';

import 'package:sessions/_variables/common_variables.dart';
import 'package:sessions/_widgets/components/toast.dart';

import '../../../_providers/_provider_variables.dart';

int getRemainingTime() {
  int remainingTime = pomodoroProviderX.end.difference(DateTime.now()).inSeconds;

  return remainingTime;
}

String getRemainingTimeString() {
  int remainingTime = pomodoroProviderX.end.difference(DateTime.now()).inSeconds;

  String seconds = (remainingTime % 60).toString();
  String minutes = (remainingTime / 60).truncate().toString();

  return '${minutes.length < 2 ? '0$minutes' : minutes}:${seconds.length < 2 ? '0$seconds' : seconds}';
}

String getTimerString(Duration timer) {
  int time = timer.inSeconds;

  String seconds = (time % 60).toString();
  String minutes = (time / 60).truncate().toString();

  return '${minutes.length < 2 ? '0$minutes' : minutes}:${seconds.length < 2 ? '0$seconds' : seconds}';
}

void startTimer(String type, Duration timer, {int? remainingTime}) {
  pomodoroProviderX.updateStartStop(remainingTime != null ? Duration(seconds: remainingTime) : timer);

  pomodoroProviderX.updateCounter(Timer.periodic(const Duration(seconds: 1), (counter_) {
    // if timer is done
    if (getRemainingTime() == 0) {
      print('done timing');
      counter_.cancel();
      pomodoroProviderX.resetAllTimers();
      autoPlayTimers(type);
    }
    // show reminder if 5 minutes is left to stop timer
    // if ((getRemainingTime() / 60) == 5) {
    if (getRemainingTime() == 5) {
      showToast(2, '5 Minutes left!');
    }
    pomodoroProviderX.updateRemainingTime(type, getRemainingTime());
  }));

  if (type == 'focus' || type == 'longBreak') {
    pomodoroProviderX.updateTimerLoops();
  }

  print('${remainingTime != null ? 'resuming' : 'started'} timing: $type');
}

void manageTimer(String type, Duration timer, int remainingTime) {
  if (pomodoroProviderX.currentTimer != type) {
    pomodoroProviderX.resetAllTimers();
  }
  //
  //
  // Pausing / Resuming
  //
  //
  if (pomodoroProviderX.currentTimer != 'none') {
    if (pomodoroProviderX.isPaused) {
      // resume timimg
      pomodoroProviderX.updateIsPaused(false);
      startTimer(type, timer, remainingTime: remainingTime);
    } else {
      // pause timimg
      pomodoroProviderX.updateIsPaused(true);
      pomodoroProviderX.cancelCounter();
      print('pausing timing');
    }
  }
  //
  //
  // Start / Stop Timer
  //
  //
  else {
    // start timing
    pomodoroProviderX.resetAllTimers();
    pomodoroProviderX.updateCurrentTimer(type);
    startTimer(type, timer);
  }
  //
  //
  //
}

void autoPlayTimers(String previousType) {
  String type = pomodoroProviderX.timerLoops == int.parse(pomodoroProviderX.pomodoroMap['longBreakInterval'] ?? '4')
      ? 'longBreak'
      : previousType == 'focus'
          ? 'break'
          : 'focus';

  if (pomodoroProviderX.pomodoroMap['autoPlay'] == '1') {
    print('autoplaying');

    showToast(1, 'Time for ${pomodoroTitles[type]}!');

    Duration timer = Duration(seconds: int.parse(pomodoroProviderX.pomodoroMap['${type}Time'] ?? '0'));

    pomodoroProviderX.updateCurrentTimer(type);
    startTimer(type, timer);
  } else {
    showToast(1, '${pomodoroTitles[previousType]} is done!');
  }
}
