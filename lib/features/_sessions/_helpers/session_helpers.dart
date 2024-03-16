import 'package:flutter/cupertino.dart';
import 'package:sessions/_providers/_provider_variables.dart';

import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../new_session/session_sheet.dart';

Future<void> prepareSessionEditing({required String sessionDate, required Map sessionData}) async {
  sessionInputProviderX.clearData();
  sessionInputProviderX.updateAllInputData(sessionData);
  sessionInputProviderX.addToSessionSelectedDates(sessionDate);
  showSessionBottomSheet(isNewSession: false);
}

Future<void> prepareSessionCreation() async {
  sessionInputProviderX.clearData();
  showSessionBottomSheet(isNewSession: true);
}

Future<void> prepareSessionCreationFromDay(String dateToday, int hour) async {
  sessionInputProviderX.clearData();
  sessionInputProviderX.addToSessionSelectedDates(dateToday);
  sessionInputProviderX.addToSessionInputData('s', '$hour:0');
  showSessionBottomSheet(isNewSession: true);
}

Future<void> prepareSessionCreationFromMonth(String dateToday) async {
  sessionInputProviderX.clearData();
  sessionInputProviderX.addToSessionSelectedDates(dateToday);
  showSessionBottomSheet(isNewSession: true);
}

void updateSelectedSession({required String sessionId, required Map sessionData}) {
  sessionProviderX.updateSelectedSession(sessionData, sessionId);
}

void clearAllSelectedDates(BuildContext context) async {
  await showConfirmationDialog(
    title: 'Clear all selected dates?',
    yeslabel: 'Clear',
    content: "You can delete individual dates by tapping 'x' on them.",
  ).then((deleteYeah) {
    if (deleteYeah == true) {
      sessionInputProviderX.clearSessionSelectedDates();
    }
  });
}

Map getHourMap(Map source, int hour) {
  source.removeWhere((key, value) => value['s'].toString().split(':')[0] != hour.toString());
  return source;
}
