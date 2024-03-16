import '../../../_widgets/components/bottom_sheet.dart';
import '_helpers/checks.dart';
import '_w/task_appbar.dart';
import '_w/task_content.dart';
import '_w/task_footer.dart';

Future<void> showTaskBottomSheet({required bool isNewTask}) async {
  await showAppBottomSheet(
    //
    noContentHorizontalPadding: true,
    //
    // Header
    //
    header: TaskAppBar(isNewTask: isNewTask),
    //
    // Content
    //
    content: TaskContent(),
    //
    // Footer
    //
    footer: TaskFooter(),
    //
    // Do when bottomSheet is closed
    //
    whenComplete: () => checkForChangeTasks(isNewTask),
  );
}
