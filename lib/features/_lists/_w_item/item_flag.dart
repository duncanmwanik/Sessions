import 'package:flutter/material.dart';
import 'package:sessions/_providers/_provider_variables.dart';

import '../../../_config/styling/styler.dart';
import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_variables/common_variables.dart';
import '../../../_widgets/components/icons.dart';
import '../../../_widgets/components/text_styles.dart';
import '../../_tables/_helpers/checks_table.dart';
import '../../flags/_helpers/get_data.dart';
import '../../flags/dialog_manage_flags.dart';

class ItemFlag extends StatelessWidget {
  const ItemFlag({Key? key, required this.flag, this.isTinyFlag = false, this.isMiniEdit = false, this.onPressedDelete}) : super(key: key);

  final String flag;
  final bool isTinyFlag;
  final bool isMiniEdit;
  final Function()? onPressedDelete;

  @override
  Widget build(BuildContext context) {
    return isTinyFlag
        ? InkWell(
            onTap: isMiniEdit
                ? () async {
                    List alreadySelectedFlags = getSplitList(listItemInputProviderX.listItemData['g']);
                    await showFlagsDialog(alreadySelectedFlags).then((flagList) {
                      if (flagList != null) {
                        listItemInputProviderX.addToListItemData('g', getJoinedList(flagList));
                      }
                    });
                  }
                : null,
            borderRadius: BorderRadius.circular(borderRadiusSmall),
            child: Container(
              width: 40,
              height: 8,
              decoration: BoxDecoration(
                color: flagColors[getFlagColor(flag)]!.color,
                borderRadius: BorderRadius.circular(borderRadiusSmall),
              ),
            ),
          )
        : InkWell(
            onTap: () async {
              List alreadySelectedFlags = getSplitList(listItemInputProviderX.listItemData['g']);
              await showFlagsDialog(alreadySelectedFlags).then((flagList) {
                if (flagList != null) {
                  listItemInputProviderX.addToListItemData('g', getJoinedList(flagList));
                }
              });
            },
            borderRadius: BorderRadius.circular(borderRadiusMedium),
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 5, top: 2, bottom: 2),
              decoration: BoxDecoration(
                color: flagColors[getFlagColor(flag)]!.color,
                borderRadius: BorderRadius.circular(borderRadiusMedium),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  // Flag Text
                  //
                  Flexible(child: AppText(size: medium, text: flag, textColor: flagColors[getFlagColor(flag)]!.textColor)),
                  //
                  // smallSpacerWidth(),
                  //
                  // Remove Flag
                  //
                  if (isTableAdmin())
                    AppIconButton(
                      Icons.close,
                      color: flagColors[getFlagColor(flag)]!.textColor,
                      onPressed: onPressedDelete ?? () {},
                      size: textSizeNormal,
                      noPadding: true,
                    ),
                  //
                  //
                ],
              ),
            ),
          );
  }
}
