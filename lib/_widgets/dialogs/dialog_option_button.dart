import 'package:flutter/material.dart';

import '../../_config/styling/styler.dart';
import '../components/icons.dart';
import '../components/text_styles.dart';

class DialogOptionButton extends StatelessWidget {
  const DialogOptionButton({Key? key, required this.label, required this.iconData, this.onTap}) : super(key: key);

  final String label;
  final IconData iconData;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusMedium)),
      leading: AppIcon(iconData),
      title: AppText(size: medium, text: label),
      onTap: onTap,
    );
  }
}
