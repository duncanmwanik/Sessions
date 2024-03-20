import 'package:flutter/material.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_widgets/others/scroll.dart';
import 'entry_list.dart';
import 'files.dart';
import 'new_entry_btn.dart';
import 'task_labels.dart';
import 'task_reminder.dart';
import 'task_title_input.dart';

class TaskContent extends StatelessWidget {
  const TaskContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 20),
      physics: TopBlockedBouncingScrollPhysics(),
      children: [
        //
        TaskTitleInput(isNewTask: false),
        //
        TaskEntries(),
        //  NoteSuperEditor(),
        //
        NewEntryButton(),
        //
        mediumSpacerHeight(),
        //
        TaskReminder(),
        //
        TaskLabels(),
        //
        TaskFiles(),
        //
        largePlaceHolderHeight(),
        //
      ],
    );
  }
}
