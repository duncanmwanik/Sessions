import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/components/buttons.dart';
import 'package:sessions/_widgets/components/icons.dart';
import 'package:sessions/_widgets/components/tooltip.dart';
import 'package:sessions/features/_sessions/_helpers/session_helpers.dart';

import '../../_config/styling/spacing.dart';
import '../../_providers/common_providers/views_provider.dart';
import '../../_variables/common_variables.dart';
import '../../features/_lists/_w_list/dialog_create_list.dart';
import '../../features/notes/_helpers/tasks_helper.dart';
import 'text_styles.dart';

class WebCreator extends StatelessWidget {
  const WebCreator({Key? key, this.isCollapsed = false}) : super(key: key);

  final bool isCollapsed;

  @override
  Widget build(BuildContext context) {
    return Consumer2<ViewsProvider, ViewsProvider>(builder: (context, viewsProvider, viewProvider, child) {
      int view = viewsProvider.selectedHomeView;

      bool isSessionView = view == sessionsViewNo;
      bool isBoardView = view == listsViewNo;
      bool isNoteView = view == notesViewNo;

      List texts = ['Session', 'Note', 'List', 'Message', 'Fun'];

      String text = 'Create ${texts[view]}';

      return isCollapsed
          ? AppTooltip(
              message: text,
              axisDirection: AxisDirection.right,
              child: AppButton(
                isRound: true,
                child: AppIcon(Icons.add_circle_rounded, tiny: true),
                onPressed: () {
                  if (isSessionView) {
                    prepareSessionCreation();
                  }
                  if (isBoardView) {
                    showCreateListDialog();
                  }
                  if (isNoteView) {
                    prepareTaskForCreation();
                  }
                },
              ),
            )
          : AppButton(
              onPressed: () {
                if (isSessionView) {
                  prepareSessionCreation();
                }
                if (isBoardView) {
                  showCreateListDialog();
                }
                if (isNoteView) {
                  prepareTaskForCreation();
                }
              },
              child: Row(
                children: [
                  AppIcon(Icons.add_circle_rounded, tiny: true),
                  smallSpacerWidth(),
                  AppText(size: medium, text: text),
                ],
              ),
            );
    });
  }
}
