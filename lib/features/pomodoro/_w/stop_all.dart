import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/components/icons.dart';
import 'package:sessions/features/pomodoro/_state/pomodoro_provider.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_config/styling/styler.dart';

class StopAllButton extends StatelessWidget {
  const StopAllButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroProvider>(builder: (context, pomoProvider, child) {
      return Visibility(
        visible: pomoProvider.currentTimer != 'none',
        child: ElevatedButton(
          onPressed: () => pomoProvider.resetAllTimers(),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.zero,
            backgroundColor: styler.isDarkTheme ? styler.white : styler.itemColor(),
            minimumSize: minSizeZero(),
            fixedSize: Size(50, 50),
            side: BorderSide.none,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: AppIcon(
            Icons.stop_rounded,
            size: 30,
            color: styler.black,
          ),
        ),
      );
    });
  }
}
