import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_widgets/components/text_styles.dart';
import 'package:sessions/features/tts/_w/tts_button.dart';

import '../../../_widgets/components/buttons.dart';

class TTSAppBar extends StatelessWidget {
  const TTSAppBar({Key? key}) : super(key: key);

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
              AppText(text: 'Text-To-Speech'),
              //
            ],
          ),
        ),
        //
        // Actions
        //
        TTSButton(),
        //
      ],
    );
  }
}
