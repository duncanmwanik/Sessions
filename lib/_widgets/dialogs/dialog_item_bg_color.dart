import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/breakpoints.dart';
import 'package:sessions/_config/styling/styler.dart';

import '../../_config/styling/spacing.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_variables/common_variables.dart';
import '../../_variables/text_descriptions.dart';
import '../components/icons.dart';
import 'app_dialog.dart';
import 'dialog_buttons.dart';

Future showPickItemBgColor({String color = ''}) {
  List colorNosList = itemBgColors.keys.toList();

  return showAppDialog(
    title: chooseColorText,
    content: GridView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(0),
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isSmallPC() ? 6 : 4,
        mainAxisSpacing: kIsWeb ? smallWidth() : tinyWidth(),
        crossAxisSpacing: kIsWeb ? smallWidth() : tinyWidth(),
      ),
      children: List.generate(colorNosList.length, (index) {
        String colorNo = colorNosList[index];

        return ElevatedButton(
          onPressed: () {
            popWhatsOnTop(value: colorNo);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: getItemColor(colorNo),
            shape: CircleBorder(),
            side: colorNo == 'x' ? BorderSide(color: styler.borderColor()) : BorderSide.none,
          ),
          child: AppIcon(
            colorNo == 'x' ? Icons.close : Icons.done_rounded,
            size: 30,
            color: colorNo == 'x'
                ? styler.textColorFaded()
                : color == colorNo
                    ? Colors.black54
                    : styler.transparent,
          ),
        );
      }),
    ),
    actions: [
      DialogActionButtonCancel(label: 'Close'),
    ],
  );
}
