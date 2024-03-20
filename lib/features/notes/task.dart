import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_config/styling/styler.dart';
import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_providers/common_providers/item_selection_provider.dart';
import '../../../_widgets/components/checkbox.dart';
import '../../../_widgets/components/text_styles.dart';
import '../../../_widgets/item_actions/hover_actions.dart';
import '../../_config/styling/helpers.dart';
import '../labels/label_list.dart';
import '../reminders/reminder.dart';
import '_helpers/tasks_helper.dart';

class Task extends StatefulWidget {
  const Task({Key? key, required this.taskId, required this.taskData}) : super(key: key);

  final String taskId;
  final Map taskData;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    Map subTasksData = widget.taskData['i'] ?? {};
    String reminder = widget.taskData['r'] ?? '';
    String labels = widget.taskData['l'] ?? '';
    String bgColor = widget.taskData['c'] ?? '';
    bool isPinned = (widget.taskData['p'] ?? '0') == '1';
    bool isArchived = (widget.taskData['a'] ?? '0') == '1';
    bool isDeleted = (widget.taskData['x'] ?? '0') == '1';
    bool isColorInverted = hasBGColor(bgColor) || isImageTheme();

    return Consumer<ItemSelectionProvider>(builder: (context, selectionProvider, child) {
      bool isSelection = selectionProvider.selectedItemMap.isNotEmpty;
      bool isSelected = selectionProvider.selectedItemMap.containsKey(widget.taskId);

      return InkWell(
        onHover: (value) => setState(() => isHovered = value),
        onTap: () {
          if (selectionProvider.selectedItemMap.isEmpty) {
            prepareTaskForEdit(widget.taskId, widget.taskData);
          } else {
            if (selectionProvider.selectedItemMap.containsKey(widget.taskId)) {
              selectionProvider.removeFromSelectedItemMap(widget.taskId);
            } else {
              selectionProvider.addToSelectedItemMap(widget.taskId, widget.taskData['t'] ?? '', isPinned, 'tasks');
            }
          }
        },
        onLongPress: () {
          if (selectionProvider.selectedItemMap.containsKey(widget.taskId)) {
            selectionProvider.removeFromSelectedItemMap(widget.taskId);
          } else {
            selectionProvider.addToSelectedItemMap(widget.taskId, widget.taskData['t'] ?? '', isPinned, 'tasks');
          }
        },
        focusColor: styler.transparent,
        hoverColor: styler.transparent,
        splashColor: styler.transparent,
        highlightColor: styler.transparent,
        child: Container(
          padding: kIsWeb ? itemPadding(left: true, right: true, top: true) : itemPaddingLarge(),
          constraints: BoxConstraints(minHeight: 70, maxWidth: 500),
          decoration: BoxDecoration(
            color: getItemColor(widget.taskData['c'], isHovered: isHovered),
            borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
            border: styler.itemBorder(isSelected, hasBgColor: hasItemColor(widget.taskData['c'])),
          ),
          child: Column(
            children: [
              //
              // Task Overview
              //
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    // Title
                    //
                    Flexible(
                      child: AppText(
                        size: normal,
                        text: widget.taskData['t'] ?? '',
                        textColor: styler.textColor(inverted: isColorInverted),
                        maxlines: 3,
                      ),
                    ),
                    //
                    //
                    if (kIsWeb) mediumSpacerHeight(),
                    if (!kIsWeb) mediumSmallSpacerHeight(),
                    //
                    // Task Entries
                    //
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: subTasksData.length > 5 ? 5 : subTasksData.length,
                        separatorBuilder: (context, index) => SizedBox(height: 5),
                        itemBuilder: (context, index) {
                          String subTaskId = subTasksData.keys.toList()[index];
                          bool isEntryChecked = subTasksData[subTaskId]['v'] == '1';
                          bool isSubtitle = subTasksData[subTaskId]['v'] == 's';
                          bool isText = subTasksData[subTaskId]['v'] == 't';

                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //
                              // Entry Checkbox ot Subtitle Icon
                              //
                              if (!isSubtitle & !isText)
                                IgnorePointer(
                                  child: CheckBoxOverview(isChecked: isEntryChecked, bgColor: bgColor, isTiny: true, faded: true),
                                ),
                              //
                              if (!isSubtitle & !isText) smallSpacerWidth(),
                              //
                              // Entry Text
                              //
                              Flexible(
                                  child: AppText(
                                size: medium,
                                text: subTasksData[subTaskId]['t'] ?? '',
                                fontWeight: isSubtitle ? FontWeight.w500 : FontWeight.w400,
                                textColor: styler.textColor(inverted: isColorInverted).withOpacity(0.75),
                                maxlines: 5,
                                overflow: TextOverflow.ellipsis,
                                isCrossed: isEntryChecked,
                              )),
                              //
                              //
                            ],
                          );
                        }),
                    //
                    // No of extra entries not shown
                    //
                    if (subTasksData.length > 5)
                      Padding(
                        padding: EdgeInsets.only(left: 5, top: 5),
                        child: AppText(size: small, text: '...', textColor: styler.textColorFaded(inverted: isColorInverted)),
                      ),
                    //
                    smallSpacerHeight(),
                    //
                    //
                    //
                    IgnorePointer(
                      ignoring: isSelection,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          // Reminder
                          //
                          if (reminder.isNotEmpty) smallSpacerHeight(),
                          if (reminder.isNotEmpty) Reminder(where: 'tasks', itemId: widget.taskId, reminder: reminder, bgColor: bgColor),
                          //
                          // Label list
                          if (labels.isNotEmpty) smallSpacerHeight(),
                          if (labels.isNotEmpty) LabelList(where: 'tasks', itemId: widget.taskId, labelString: labels, bgColor: bgColor),
                          //
                          //
                          //
                        ],
                      ),
                    ),
                    //
                    //
                    //
                  ],
                ),
              ),
              //
              // We show onHover buttons if on web
              //
              if (kIsWeb)
                HoverActions(
                  showHoverOptions: isHovered,
                  isPinned: isPinned,
                  isArchived: isArchived,
                  isDeleted: isDeleted,
                  itemId: widget.taskId,
                  itemData: widget.taskData,
                  bgColor: bgColor,
                  type: 'tasks',
                ),
              //
              //
              //
            ],
          ),
        ),
      );
    });
  }
}
