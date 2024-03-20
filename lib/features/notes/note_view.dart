import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../_config/styling/breakpoints.dart';
import '../../_config/styling/spacing.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_providers/common_providers/layout_provider.dart';
import '../../_widgets/components/text_styles.dart';
import '../../_widgets/others/empty_box.dart';
import '../_tables/_helpers/get_table_data.dart';
import '../labels/_state/labels_provider.dart';
import 'note.dart';

class TaskView extends StatelessWidget {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LabelsProvider>(builder: (context, labelsProvider, child) {
      return ValueListenableBuilder(
          valueListenable: Hive.box('${currentSelectedTable()}_tasks').listenable(),
          builder: (context, box, widget) {
            List allTaskIds = box.keys.toList();
            List pinnedTasks = [];
            List unpinnedTasks = [];
            String currentLabel = labelsProvider.selectedLabel;

            for (var id in allTaskIds) {
              Map taskData = box.get(id);
              List labelList = getSplitList(taskData['l']);
              bool isDeleted = taskData['x'] != null ? taskData['x'].toString() == '1' : false;
              bool isArchived = taskData['a'] != null ? taskData['a'].toString() == '1' : false;
              bool isPinned = taskData['p'] != null ? taskData['p'].toString() == '1' : false;

              if (isDeleted) {
                if (currentLabel == 'Trash') {
                  if (isPinned) {
                    pinnedTasks.add(id);
                  } else {
                    unpinnedTasks.add(id);
                  }
                }
              } else if (isArchived) {
                if (currentLabel == 'Archive' && !isDeleted) {
                  if (isPinned) {
                    pinnedTasks.add(id);
                  } else {
                    unpinnedTasks.add(id);
                  }
                }
              } else {
                if ((currentLabel == 'All' || labelList.contains(currentLabel)) && !isDeleted && !isArchived) {
                  if (isPinned) {
                    pinnedTasks.add(id);
                  } else {
                    unpinnedTasks.add(id);
                  }
                }
              }
            }

            //
            // Grid View: crossAxisCount = 2 or 3 depending of screen width
            // Column View: crossAxisCount = 1
            //
            return Consumer<LayoutProvider>(builder: (context, layoutProvider, child) {
              bool isGridLayout = layoutProvider.layoutNotes == 'grid';

              return ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  //
                  // Pinned Tasks
                  //
                  if (pinnedTasks.isNotEmpty) PinnedInfoText(text: 'Pinned'),
                  //
                  //
                  MasonryGridView.count(
                    key: UniqueKey(),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: isGridLayout ? gridCount() : 1,
                    crossAxisSpacing: isPhone() ? smallWidth() : mediumWidth(),
                    mainAxisSpacing: isPhone() ? smallWidth() : mediumWidth(),
                    itemCount: pinnedTasks.length,
                    itemBuilder: (context, index) {
                      String taskId = pinnedTasks[index];
                      final Map taskData = box.get(taskId);

                      return isGridLayout ? Task(taskId: taskId, taskData: taskData) : UnconstrainedBox(child: Task(taskId: taskId, taskData: taskData));
                    },
                  ),
                  //
                  // Unpinned Tasks
                  //
                  if (pinnedTasks.isNotEmpty && unpinnedTasks.isNotEmpty) PinnedInfoText(text: 'Others'),
                  if (pinnedTasks.isEmpty) smallSpacerHeight(),
                  //
                  //
                  MasonryGridView.count(
                    key: UniqueKey(),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: isGridLayout ? gridCount() : 1,
                    crossAxisSpacing: isPhone() ? smallWidth() : mediumWidth(),
                    mainAxisSpacing: isPhone() ? smallWidth() : mediumWidth(),
                    itemCount: unpinnedTasks.length,
                    itemBuilder: (context, index) {
                      String taskId = unpinnedTasks[index];
                      final Map taskData = box.get(taskId);

                      return isGridLayout ? Task(taskId: taskId, taskData: taskData) : UnconstrainedBox(child: Task(taskId: taskId, taskData: taskData));
                    },
                  ),
                  //
                  //
                  if (unpinnedTasks.isEmpty && pinnedTasks.isEmpty) EmptyBox(label: 'No notes'),
                  //
                  //
                  largePlaceHolderHeight(),
                  largePlaceHolderHeight(),
                  //
                  //
                ],
              );
            });
          });
    });
  }
}
