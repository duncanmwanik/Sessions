import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/styler.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({Key? key, required this.leading, this.trailing, this.onTap, this.color}) : super(key: key);

  final Widget leading;
  final Widget? trailing;
  final Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      trailing: trailing,
      onTap: onTap,
      tileColor: color ?? styler.primaryColor(),
    );
  }
}
