import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_config/styling/breakpoints.dart';
import '../../../_config/styling/styler.dart';
import '../../../_providers/common_providers/datetime_provider.dart';
import '../../../_providers/common_providers/views_provider.dart';
import '../../../_variables/common_variables.dart';
import '../../_sessions/_helpers/session_helpers.dart';
import '../../_tables/_helpers/checks_table.dart';
import '../../labels/_state/labels_provider.dart';
import '../../notes/_helpers/tasks_helper.dart';

class HomeFABS extends StatelessWidget {
  const HomeFABS({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<ViewsProvider, DateTimeProvider, LabelsProvider>(builder: (context, viewsProvider, dateProvider, labelsProvider, child) {
      int view = viewsProvider.selectedHomeView;

      bool isSessionView = view == sessionsViewNo;
      bool isBoardView = view == listsViewNo;
      bool isNoteView = view == notesViewNo;
      bool showCreateFab = [sessionsViewNo, notesViewNo].contains(viewsProvider.selectedHomeView);

      return Visibility(
        visible: isThereATableSelected() && isTableAdmin() && isTabAndBelow() && showCreateFab,
        child: FloatingActionButton(
          heroTag: null,
          elevation: 1,
          tooltip: 'Create ${isSessionView ? 'Session' : isBoardView ? 'List' : isNoteView ? 'Note' : ''}',
          backgroundColor: styler.accentColor(),
          hoverColor: Colors.black12,
          shape: CircleBorder(),
          onPressed: () {
            if (isSessionView) {
              prepareSessionCreation();
            }
            if (isNoteView) {
              prepareTaskForCreation();
            }
          },
          child: Icon(
            Icons.add_rounded,
            size: 40,
            color: styler.white,
          ),
        ),
      );
    });
  }
}
