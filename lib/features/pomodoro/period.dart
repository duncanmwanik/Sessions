import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_config/styling/styler.dart';
import 'package:sessions/_helpers/date_time/datetime_helper.dart';
import 'package:sessions/_variables/common_variables.dart';
import 'package:sessions/_widgets/components/icons.dart';
import 'package:sessions/features/pomodoro/_state/pomodoro_provider.dart';

import '../../_widgets/components/text_styles.dart';
import '_helpers/helpers.dart';

class PomodoroPeriod extends StatelessWidget {
  const PomodoroPeriod({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroProvider>(builder: (context, pomoProvider, child) {
      Map typeRemainingTimes = {'focus': pomoProvider.remainingTimeFocus, 'break': pomoProvider.remainingTimeBreak, 'longBreak': pomoProvider.remainingTimeLongBreak};

      // Duration timer = Duration(minutes: int.parse(pomoProvider.pomodoroMap['${type}Time'] ?? '0'));
      Duration timer = Duration(seconds: int.parse(pomoProvider.pomodoroMap['${type}Time'] ?? '0'));

      bool isCurrentTimer = pomoProvider.currentTimer == type;

      return InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(borderRadiusMediumSmall + 2),
        child: Container(
          decoration: BoxDecoration(
            color: pomoColors[pomoProvider.pomodoroMap['${type}Color']]!.withOpacity(isCurrentTimer ? 0.2 : 0.8),
            borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadiusMediumSmall - 2),
            child: Stack(
              children: [
                //
                //
                //
                LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
                  double width = constraints.maxWidth;

                  int passedTime = (timer.inSeconds - typeRemainingTimes[type]).toInt();

                  return Container(
                    height: 150,
                    width: isCurrentTimer ? width * ((passedTime == timer.inSeconds ? 1 : passedTime) / timer.inSeconds) : 0,
                    decoration: BoxDecoration(color: pomoColors[pomoProvider.pomodoroMap['${type}Color']]),
                  );
                }),
                //
                //
                //
                Container(
                  height: 150,
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 15),
                  decoration: BoxDecoration(
                    color: styler.transparent,
                    borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      // Title
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //
                                // Timer Title
                                //
                                Flexible(child: AppText(size: appBar, text: pomodoroTitles[type] ?? '-', fontWeight: FontWeight.w900)),
                                //
                                smallSpacerHeight(),
                                //
                                // Remaining Time
                                //
                                Flexible(
                                    child: AppText(
                                  size: pomodoro,
                                  text: isCurrentTimer ? getRemainingTimeString() : getTimerString(timer),
                                  fontWeight: FontWeight.w900,
                                )),
                                //
                                //
                              ],
                            ),
                          ),
                          //
                          // Pause / Play Timer
                          //
                          ElevatedButton(
                            onPressed: () => manageTimer(type, timer, typeRemainingTimes[type]),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.zero,
                              backgroundColor: styler.white,
                              disabledBackgroundColor: styler.transparent,
                              minimumSize: minSizeZero(),
                              fixedSize: Size(70, 70),
                              side: BorderSide.none,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: AppIcon(
                              isCurrentTimer
                                  ? pomoProvider.isPaused
                                      ? Icons.play_arrow_rounded
                                      : Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              size: isCurrentTimer
                                  ? pomoProvider.isPaused
                                      ? 70
                                      : 50
                                  : 70,
                              color: styler.black,
                            ),
                          ),
                          //
                          //
                        ],
                      ),
                      //
                      //
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //
                          // Time to stop
                          //
                          Flexible(
                            child: Row(
                              children: [
                                AppText(
                                  size: medium,
                                  text: 'Stops at ',
                                  textColor: isCurrentTimer ? null : Colors.transparent,
                                ),
                                Flexible(
                                    child: AppText(
                                  size: medium,
                                  text: isCurrentTimer
                                      ? get12HourTimeFrom24HourTime(
                                          getTimePartFromTimeOfDay(TimeOfDay.fromDateTime(pomoProvider.end)),
                                          showSeconds: true,
                                          islonger: true,
                                        )
                                      : '-',
                                  fontWeight: FontWeight.w900,
                                  textColor: isCurrentTimer ? null : Colors.transparent,
                                )),
                              ],
                            ),
                          ),
                          //
                          //
                          //
                        ],
                      ),
                      //
                      //
                      //
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
