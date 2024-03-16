import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_config/styling/styler.dart';
import '../_state/task_input_provider.dart';

class TaskTitleInput extends StatelessWidget {
  const TaskTitleInput({super.key, required this.isNewTask});

  final bool isNewTask;

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskInputProvider>(builder: (context, inputProvider, child) {
      return TextFormField(
        onChanged: (value) {
          inputProvider.addToTaskInputData('t', value.trim());
        },
        initialValue: inputProvider.taskInputData['t'] ?? '',
        minLines: 1,
        maxLines: null,
        textInputAction: TextInputAction.next,
        style: TextStyle(fontSize: textSizeTitle, fontWeight: FontWeight.w500, color: styler.textColor()),
        decoration: InputDecoration(hintText: 'Title', hintStyle: TextStyle(fontSize: textSizeTitle, fontWeight: FontWeight.w500), border: InputBorder.none),
      );
    });
  }
}
