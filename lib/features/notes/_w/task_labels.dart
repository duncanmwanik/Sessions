import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/features/labels/label_list.dart';

import '../../../../_config/styling/spacing.dart';
import '../_state/task_input_provider.dart';

class TaskLabels extends StatelessWidget {
  const TaskLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskInputProvider>(builder: (context, inputProvider, child) {
      String labels = inputProvider.taskInputData['l'] ?? '';

      return Visibility(
        visible: labels.isNotEmpty,
        child: Padding(
          padding: itemPadding(top: true, left: true, right: true),
          child: LabelList(
            where: 'tasks',
            labelString: labels,
          ),
        ),
      );
    });
  }
}
