import 'package:flutter/material.dart';
import 'package:sessions/_widgets/components/toast.dart';
import 'package:styled_text/styled_text.dart';

import '../../_config/styling/breakpoints.dart';
import '../../_config/styling/styler.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_variables/navigation_variables.dart';
import 'icons.dart';

void showSnackBar(String message) {
  try {
    // we show the snackbar only for mobile
    if (isPhone()) {
      ScaffoldMessenger.of(homeX.currentContext!).clearSnackBars();
      ScaffoldMessenger.of(homeX.currentContext!).showSnackBar(SnackBar(
        padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
        content: Row(
          children: [
            //
            // Message
            //
            Expanded(
              child: StyledText(
                text: message,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: textSizeMedium),
                tags: {
                  'b': StyledTextTag(style: TextStyle(fontWeight: FontWeight.w700, fontSize: textSizeMedium)),
                },
              ),
            ),
            //
            // Close snackbar
            //
            AppIconButton(
              Icons.close_rounded,
              color: styler.invertedTextColor(),
              onPressed: () => closeAllSnackBars(),
            )
            //
          ],
        ),
      ));
    } else {
      // if on large screen, we show a toast instead
      showToast(2, message);
    }
  } catch (_) {}
}
