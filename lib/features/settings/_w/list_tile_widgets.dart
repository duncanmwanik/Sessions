import 'package:flutter/material.dart';

import '../../../_config/styling/breakpoints.dart';
import '../../../_config/styling/styler.dart';
import '../../../_widgets/components/text_styles.dart';

Widget divider() {
  return const Divider(height: 0);
}

class SettingTitle extends StatelessWidget {
  const SettingTitle(
    this.title, {
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: styler.appColor(2.2),
        borderRadius: showSheetAsDialog() ? BorderRadius.circular(borderRadiusSmall) : null,
      ),
      child: AppText(size: normal, text: title, faded: true),
    );
  }
}
