import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sessions/_config/styling/styler.dart';
import 'package:sessions/_providers/_provider_variables.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_variables/common_variables.dart';
import '../../../_variables/navigation_variables.dart';
import '../../../_widgets/components/buttons.dart';
import '../../../_widgets/components/icons.dart';
import '../../../_widgets/components/tooltip.dart';

Widget webHomeNavItem(IconData iconData, int viewNo, bool isSelected) => AppTooltip(
      message: navBatItems[viewNo],
      axisDirection: AxisDirection.right,
      child: InkWell(
        onTap: () {
          if (viewNo != viewsProviderX.selectedHomeView) {
            clearItemSelection();
            homeTabController.animateTo(viewNo);
            viewsProviderX.updateHomeView(viewNo);
          }
        },
        borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            // color: isSelected ? styler.itemColor() : null,
            borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
          ),
          child: AppIcon(iconData),
        ),
      ),
    );

BottomNavigationBarItem homeNavBarItem(IconData iconData, String label, bool isSelected) => BottomNavigationBarItem(
      label: label,
      icon: Tooltip(
        message: label,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
          ),
          child: AppIcon(
            iconData,
            color: isSelected ? styler.accentColor() : null,
          ),
        ),
      ),
    );

class UserProfileButton extends StatelessWidget {
  const UserProfileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppButton(
      onPressed: () => homeX.currentContext!.push('/settings'),
      isRound: true,
      noStyling: true,
      child: Container(
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(image: AssetImage('assets/images/user.png')),
        ),
      ),
    );
  }
}
