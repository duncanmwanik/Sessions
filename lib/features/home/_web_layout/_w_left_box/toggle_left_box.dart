import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_providers/common_providers/global_provider.dart';
import 'package:sessions/_widgets/components/tooltip.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../../../../_widgets/components/icons.dart';

class ToggleWebLeftBox extends StatelessWidget {
  const ToggleWebLeftBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(builder: (context, globalProvider, child) {
      bool showWebBoxOptions = globalProvider.showWebBoxOptions;

      return AppTooltip(
        message: showWebBoxOptions ? 'Collapse Side Panel' : 'Expand Side Panel',
        axisDirection: AxisDirection.right,
        child: Padding(
          padding: itemPadding(top: true),
          child: ElevatedButton(
              onPressed: () => globalProvider.updateShowWebBoxOptions(!showWebBoxOptions),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.zero,
                minimumSize: minSizeZero(),
                fixedSize: Size(30, 30),
                backgroundColor: styler.transparent,
              ),
              child: AppIcon(Icons.swap_horiz_rounded)),
        ),
      );
    });
  }
}
