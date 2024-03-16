import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_config/styling/spacing.dart';
import '../_state/task_input_provider.dart';
import 'entry.dart';

class TaskEntries extends StatefulWidget {
  const TaskEntries({Key? key}) : super(key: key);

  @override
  State<TaskEntries> createState() => _TaskEntriesState();
}

class _TaskEntriesState extends State<TaskEntries> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskInputProvider>(builder: (context, inputProvider, child) {
      return Padding(
        padding: itemPaddingSmall(top: true),
        child: Column(
            children: List.generate(inputProvider.taskHolder.length, (index) {
          String entryId = inputProvider.taskHolder.keys.toList()[index];
          Map entryData = inputProvider.taskHolder[entryId];

          return TaskEntry(entryId: entryId, entryData: entryData);
        })),
      );
    });
  }
}
