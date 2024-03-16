import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sessions/_variables/navigation_variables.dart';
import 'package:sessions/_widgets/components/text_styles.dart';

import '../../_config/styling/spacing.dart';
import '../others/other_widgets.dart';

Future<dynamic> showAppDialog({dynamic title, Widget? content, List<Widget>? actions, bool smallTopPadding = false, bool showBottomPadding = false}) {
  return showGeneralDialog<dynamic>(
    context: homeX.currentContext!,
    transitionDuration: Duration(milliseconds: 300),
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black26,
    pageBuilder: (context, animation1, animation2) => NoWidget(),
    transitionBuilder: (context, a1, a2, widget) {
      return Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: AlertDialog(
            insetPadding: dialogInsetPadding(),
            titlePadding: EdgeInsets.only(left: 24, right: 24, top: smallTopPadding ? 12 : 24),
            contentPadding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: smallTopPadding ? 3 : 24,
                bottom: kIsWeb
                    ? 24
                    : showBottomPadding
                        ? 5
                        : 0),
            //
            //
            //
            title: title.runtimeType == String ? HtmlText(size: normal, text: title) : title,
            //
            //
            //
            content: Container(
              width: infinityWidth(),
              constraints: webMaxDialogConstraints(),
              child: content,
            ),
            //
            //
            //
            actions: actions,
            //
            //
            //
          ),
        ),
      );
    },
  );
}
