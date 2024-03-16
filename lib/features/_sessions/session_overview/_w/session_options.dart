import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_widgets/components/icons.dart';

import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../_helpers/copy_session.dart';
import '../../_helpers/delete_session.dart';
import '../../_helpers/session_helpers.dart';

class SessionOptions extends StatelessWidget {
  const SessionOptions({super.key, required this.sessionDate, required this.sessionId, required this.sessionData});

  final String sessionDate;
  final String sessionId;
  final Map sessionData;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: smallWidth(),
      runSpacing: smallWidth(),
      alignment: WrapAlignment.end,
      children: [
        AppIconButton(
          onPressed: () {
            popWhatsOnTop();
            closeBottomSheetIfOpen();
            updateSelectedSession(sessionId: sessionId, sessionData: sessionData);
            prepareSessionEditing(sessionDate: sessionDate, sessionData: sessionData);
          },
          Icons.edit_rounded,
          faded: true,
          tooltip: 'Edit',
        ),
        AppIconButton(
          onPressed: () {
            copySessionToDates(previousDate: sessionDate, sessionId: sessionId, sessionData: sessionData, move: false);
          },
          Icons.copy_rounded,
          faded: true,
          tooltip: 'Copy to Date',
        ),
        AppIconButton(
          onPressed: () {
            copySessionToDates(previousDate: sessionDate, sessionId: sessionId, sessionData: sessionData, move: true);
          },
          Icons.forward_rounded,
          faded: true,
          tooltip: 'Move To Date',
        ),
        AppIconButton(
          onPressed: () {
            deleteSession(context, sessionDate: sessionDate, sessionId: sessionId, sessionName: sessionData['t']);
          },
          Icons.delete_forever_rounded,
          faded: true,
          tooltip: 'Delete',
        ),
      ],
    );
  }
}
