import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sessions/_widgets/components/icons.dart';
import 'package:styled_text/styled_text.dart';

import '../../_config/styling/spacing.dart';
import '../../_config/styling/styler.dart';
import '../../_config/styling/styling.dart';

void showToast(int type, String message, {int duration = 3}) {
  late CancelFunc cancel;

  // ignore: unused_element
  void closeToast() => cancel();

  cancel = BotToast.showAttachedWidget(
    allowClick: true,
    ignoreContentClick: kIsWeb,
    target: Offset(0, 0),
    duration: Duration(seconds: duration),
    attachedBuilder: (_) => Align(
      alignment: kIsWeb ? Alignment.topRight : Alignment.topCenter,
      child: Container(
        constraints: BoxConstraints(maxWidth: 380),
        margin: EdgeInsets.symmetric(horizontal: kIsWeb ? 1.w : 5.w, vertical: kIsWeb ? 60 : 0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: styler.toastBackgroundColor(),
          borderRadius: BorderRadius.circular(borderRadiusSmall),
          border: styler.lightBoxBorder(),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            //
            //
            Flexible(
              child: Row(
                children: [
                  //
                  // Alert Type Icon
                  //
                  AppIcon(toastIcons[type], color: AppColors.toastColors[type]),
                  //
                  mediumSpacerWidth(),
                  //
                  // Message
                  //
                  Flexible(
                    child: StyledText(
                      text: message,
                      style: TextStyle(fontSize: textSizeMedium, fontWeight: FontWeight.w500, color: styler.black),
                      tags: {
                        'b': StyledTextTag(style: TextStyle(fontSize: textSizeMedium, fontWeight: FontWeight.bold, color: styler.black)),
                      },
                    ),
                  ),
                  //
                  //
                ],
              ),
            ),
            //
            mediumSpacerWidth(),
            //
            // Close Toast Button
            //
            ElevatedButton(
              // onPressed: () => closeToast(),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.zero,
                backgroundColor: styler.transparent,
                minimumSize: minSizeZero(),
                fixedSize: Size(30, 30),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: AppIcon(Icons.close, color: Colors.black45),
            ),
            //
            //
            //
          ],
        ),
      ),
    ),
  );
}
