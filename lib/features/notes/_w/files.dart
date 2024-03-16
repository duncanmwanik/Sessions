import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/features/files/file_list.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../_state/task_input_provider.dart';

class TaskFiles extends StatelessWidget {
  const TaskFiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskInputProvider>(builder: (context, inputProvider, child) {
      return Padding(
        padding: itemPadding(top: true, left: true, right: true),
        child: FileList(fileData: getFilesOnlyMap(inputProvider.taskInputData), where: 'tasks'),
      );
    });
  }
}
