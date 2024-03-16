import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/features/labels/bottom_sheet_labels.dart';

import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_variables/navigation_variables.dart';
import '../../../../_widgets/components/buttons.dart';
import '../../../../_widgets/components/icons.dart';
import '../../reminders/dialog_set_reminder.dart';
import '../../tts/_w/tts_button.dart';
import '../_helpers/tasks_helper.dart';
import '../_state/task_input_provider.dart';

class TaskAppBar extends StatelessWidget {
  const TaskAppBar({Key? key, required this.isNewTask}) : super(key: key);

  final bool isNewTask;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        // Close BottomSheet
        CustomCloseButton(faded: true, isX: true),
        //
        // Actions
        Consumer<TaskInputProvider>(builder: (context, inputProvider, child) {
          String reminder = inputProvider.taskInputData['r'] ?? '';
          bool isPinned = (inputProvider.taskInputData['p'] ?? '0') == '1';

          return Wrap(
            children: [
              //
              // Pin item
              AppIconButton(
                onPressed: () {
                  if (isPinned) {
                    inputProvider.addToTaskInputData('p', '0');
                  } else {
                    inputProvider.addToTaskInputData('p', '1');
                  }
                },
                isPinned ? Icons.push_pin_rounded : Icons.push_pin_outlined,
                faded: true,
              ),

              //
              // Sets reminder
              AppIconButton(
                onPressed: () async {
                  hideKeyboard();
                  showSetReminderDialog(reminder: reminder).then((value) {
                    if (value != null && value != 'remove') {
                      inputProvider.addToTaskInputData('r', value);
                    }
                    if (value == 'remove') {
                      inputProvider.addToTaskInputData('r', '');
                    }
                  });
                },
                Icons.notifications_none,
                faded: true,
              ),

              //
              // Adds labels
              AppIconButton(
                onPressed: () async {
                  hideKeyboard();
                  newEntryFocusNode.unfocus();
                  List currentLabels = inputProvider.taskInputData['l'] != null ? getSplitList(inputProvider.taskInputData['l'].toString()) : [];
                  await showLabelsBottomSheet(isSelection: true, alreadySelected: currentLabels).then((labelList) {
                    if (labelList != null && labelList.isNotEmpty) {
                      inputProvider.addToTaskInputData('l', labelList.join('|'));
                    }
                  });
                },
                Icons.label_outlined,
                faded: true,
              ),
              //
              // Text To Speech
              TTSButton(text: getTaskEntriesAsText(inputProvider.taskHolder)),
              //
            ],
          );
        }),
        //
        //
        //
      ],
    );
  }
}
