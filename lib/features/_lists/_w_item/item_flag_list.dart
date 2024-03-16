import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';
import 'package:sessions/_providers/_provider_variables.dart';
import 'package:sessions/features/_lists/_w_item/item_flag.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_widgets/others/other_widgets.dart';
import '../../_tables/_helpers/get_table_data.dart';

class ItemFlagList extends StatelessWidget {
  const ItemFlagList({Key? key, required this.flagList, this.isTinyFlag = false, this.isMiniEdit = false, this.itemId, this.listId}) : super(key: key);

  final List flagList;
  final bool isTinyFlag;
  final bool isMiniEdit;
  final String? itemId;
  final String? listId;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
          spacing: 5,
          runSpacing: smallWidth(),
          children: List.generate(flagList.length, (index) {
            String flag = flagList[index] ?? 'missing*';

            // If the flag is not deleted
            if (Hive.box('${currentSelectedTable()}_flags').containsKey(flag)) {
              return ItemFlag(
                flag: flag,
                isTinyFlag: isTinyFlag,
                isMiniEdit: isMiniEdit,
                onPressedDelete: () {
                  flagList.remove(flag);
                  listItemInputProviderX.addToListItemData('g', getJoinedList(flagList));
                },
              );
            }
            // If not available, we remove the item flag from item data
            else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                flagList.remove(flag);
                listItemInputProviderX.addToListItemData('g', getJoinedList(flagList));
              });
              return NoWidget();
            }
          })),
    );
  }
}
