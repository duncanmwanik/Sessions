import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sessions/_providers/_provider_variables.dart';
import 'package:sessions/features/labels/bottom_sheet_labels.dart';

import '../../_config/styling/spacing.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_helpers/edits/edit_item_extras.dart';
import '../../_variables/common_variables.dart';
import '../../_widgets/others/other_widgets.dart';
import '../_tables/_helpers/get_table_data.dart';
import 'label.dart';

class LabelList extends StatelessWidget {
  const LabelList({super.key, required this.where, this.labelString = '', this.bgColor, this.itemId, this.isShort = false});

  final String? where;
  final String? labelString;
  final String? bgColor;
  final String? itemId;
  final bool isShort;

  @override
  Widget build(BuildContext context) {
    List labelList = [];

    if (labelString != null) {
      labelList = getSplitList(labelString ?? '');
    } else if (where == 'tasks') {
      labelList = getSplitList(taskInputProviderX.taskInputData['l']);
    } else if (where == 'lists') {
      labelList = getSplitList(listInputProviderX.listInputData['l']);
    }

    return Wrap(
        spacing: kIsWeb ? smallWidth() : tinyWidth(),
        runSpacing: kIsWeb ? smallWidth() : tinyWidth(),
        children: List.generate(labelList.length, (index) {
          String label = labelList[index];

          if (Hive.box('${currentSelectedTable()}_labels').containsKey(label)) {
            return Label(
              label: label,
              bgColor: bgColor,
              onPressed: () async {
                hideKeyboard();
                await showLabelsBottomSheet(isSelection: true, alreadySelected: labelList).then((labelList) async {
                  if (labelList != null) {
                    //
                    // if label list is not empty
                    //
                    if (labelList.isNotEmpty) {
                      if (itemId != null && where != null) {
                        await editItemExtras(where: where!, action: typeActionsEdit[where], itemId: itemId!, type: 'l', value: getJoinedList(labelList));
                      } else {
                        if (where == 'tasks') {
                          taskInputProviderX.addToTaskInputData('l', getJoinedList(labelList));
                        } else if (where == 'lists') {
                          listInputProviderX.addToListInputData('l', getJoinedList(labelList));
                        }
                      }
                    }
                    //
                    // if label list is empty, we delete the key 'l'
                    //
                    else {
                      if (itemId != null && where != null) {
                        await editItemExtras(where: where!, action: typeActionsEdit[where], itemId: itemId!, type: 'd/l', value: getJoinedList(labelList));
                      } else {
                        if (where == 'tasks') {
                          taskInputProviderX.removeFromTaskInputData('l');
                        } else if (where == 'lists') {
                          listInputProviderX.removeFromListInputData('l');
                        }
                      }
                    }
                    //
                    //
                    //
                  }
                });
              },
            );
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              labelList.remove(label);

              if (itemId != null && where != null) {
                await editItemExtras(where: where!, action: typeActionsEdit[where], itemId: itemId!, type: 'l', value: getJoinedList(labelList));
              } else {
                if (where == 'tasks') {
                  taskInputProviderX.addToTaskInputData('l', getJoinedList(labelList));
                } else if (where == 'lists') {
                  listInputProviderX.addToListInputData('l', getJoinedList(labelList));
                }
              }
            });
            return NoWidget();
          }
        }));
  }
}
