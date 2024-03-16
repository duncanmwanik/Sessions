import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../reminders/dialog_set_reminder.dart';
import '../../reminders/reminder.dart';
import '../_state/task_input_provider.dart';

class TaskReminder extends StatelessWidget {
  const TaskReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskInputProvider>(builder: (context, inputProvider, child) {
      String reminder = inputProvider.taskInputData['r'] ?? '';

      return Visibility(
        visible: reminder.isNotEmpty,
        child: Padding(
          padding: itemPadding(top: true, left: true, right: true),
          child: Row(
            children: [
              Reminder(
                reminder: reminder,
                onPressed: () async {
                  //
                  hideKeyboard();
                  //
                  showSetReminderDialog(reminder: reminder).then((value) {
                    if (value != null && value != 'remove') {
                      inputProvider.addToTaskInputData('r', value);
                    }
                    if (value == 'remove') {
                      inputProvider.removeFromTaskInputData('r');
                    }
                  });
                  //
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
