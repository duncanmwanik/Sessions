import 'package:flutter/material.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../../../../_widgets/components/icons.dart';
import '../../_helpers/checks_table.dart';

Widget tableActionButton({required String label, required IconData iconData, Function()? onPressed}) {
  return Visibility(
    visible: isTableAdmin(),
    child: Padding(
      padding: itemPaddingMedium(left: true, right: true),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: itemPadding(),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcon(iconData),
              SizedBox(width: smallWidth()),
              Text(
                label,
                style: TextStyle(fontSize: textSizeMedium),
              ),
            ],
          )),
    ),
  );
}
