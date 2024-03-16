import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';
import 'package:sessions/features/flags/_state/flag_input_provider.dart';

import '../../_config/styling/spacing.dart';
import '../../_config/styling/styler.dart';
import '../../_variables/common_variables.dart';
import '../../_widgets/components/icons.dart';

class FlagColorOptions extends StatelessWidget {
  const FlagColorOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FlagInputProvider>(builder: (context, flagProvider, child) {
      return PopupMenuButton(
        elevation: styler.isDarkTheme ? 0 : null,
        tooltip: 'Options',
        splashRadius: borderRadiusSmall,
        color: styler.secondaryColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusSmall),
          side: styler.isDarkTheme ? BorderSide(color: Colors.grey.withOpacity(0.1)) : BorderSide.none,
        ),
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: flagColors[flagProvider.selectedFlagColor]!.color,
            shape: BoxShape.circle,
          ),
          child: AppIcon(Icons.edit_rounded, size: 16, color: flagColors[flagProvider.selectedFlagColor]!.textColor),
        ),
        itemBuilder: (context) {
          return [
            //
            //
            //
            PopupMenuItem(
              enabled: false,
              height: 0,
              child: Wrap(
                spacing: tinyWidth(),
                runSpacing: tinyWidth(),
                alignment: WrapAlignment.center,
                children: List.generate(
                    flagColors.length,
                    (indexColor) => ElevatedButton(
                        onPressed: () {
                          flagProvider.updateSelectedFlagColor(indexColor.toString());
                          popWhatsOnTop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: flagColors[indexColor.toString()]!.color,
                          fixedSize: Size(50, 50),
                          shape: CircleBorder(),
                        ),
                        child: null)),
              ),
            ),
            //
            //
            //
          ];
        },
      );
    });
  }
}
