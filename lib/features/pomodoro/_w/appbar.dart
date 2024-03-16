import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_widgets/components/icons.dart';
import 'package:sessions/_widgets/components/text_styles.dart';

import '../../../_widgets/components/buttons.dart';

class PomodoroAppBar extends StatelessWidget {
  const PomodoroAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        // Close BottomSheet
        Expanded(
          child: Row(
            children: [
              //
              CustomCloseButton(),
              //
              smallSpacerWidth(),
              //
              AppText(text: 'Pomodoro', fontWeight: FontWeight.w700),
              //
            ],
          ),
        ),
        //
        // Actions
        //
        AppIconButton(Icons.settings_rounded, onPressed: () {
          showAboutDialog(context: context);
        }),
        //
      ],
    );
  }
}
