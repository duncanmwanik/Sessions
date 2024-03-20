import 'package:flutter/material.dart';

import '../../../_config/styling/breakpoints.dart';
import '../../../_config/styling/spacing.dart';
import '../../../_config/styling/styler.dart';
import '../../../_helpers/_common_helpers/theme_helper.dart';
import 'manager.dart';

class TableManagementDrawer extends StatelessWidget {
  const TableManagementDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: webDrawerWidth(),
      backgroundColor: styler.transparent,
      elevation: 0,
      shape: isNotPhone()
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
              topRight: Radius.circular(borderRadiusMedium),
              bottomRight: Radius.circular(borderRadiusMedium),
            ))
          : null,
      child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(getDefaultThemeImage()),
              fit: BoxFit.cover,
            ),
          ),
          child: TableManager()),
    );
  }
}
