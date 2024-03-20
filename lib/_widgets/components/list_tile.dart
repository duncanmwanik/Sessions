import 'package:flutter/material.dart';
import 'package:sessions/_widgets/others/other_widgets.dart';

import '../../_config/styling/styler.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({Key? key, required this.leading, this.trailing, this.onTap}) : super(key: key);

  final Widget leading;
  final Widget? trailing;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadiusSmall),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: styler.appColor(1),
          borderRadius: BorderRadius.circular(borderRadiusSmall),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //
            leading,
            //
            trailing ?? NoWidget(),
            //
          ],
        ),
      ),
    );
  }
}
