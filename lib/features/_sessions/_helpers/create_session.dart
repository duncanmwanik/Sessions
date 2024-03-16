import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_providers/_provider_variables.dart';
import '../../../_services/cloud/sync_to_cloud.dart';
import '../../../_widgets/components/toast.dart';
import '../../_tables/_helpers/get_table_data.dart';
import '../../files/_helpers/upload_files.dart';
import '../../reminders/_helpers/register_reminder.dart';
import 'checks.dart';

Future<void> createNewSession(BuildContext context, Map newSessionData) async {
  try {
    String sessionId = DateTime.now().microsecondsSinceEpoch.toString();
    List selectedDates = sessionInputProviderX.sessionSelectedDates;
    String tableId = currentSelectedTable();

    String message = validateNewSessionInput(newSessionData['t'], newSessionData['s'], selectedDates);
    if (message.isEmpty) {
      closeBottomSheetIfOpen();

      // remove duplicate reminders
      newSessionData['r'] = getJoinedList(getSplitList(newSessionData['r']).toSet().toList());

      // remove keys with empty values
      newSessionData.removeWhere((key, value) => value.toString().isEmpty);

      Box box = Hive.box(tableId);

      for (String date in selectedDates) {
        Map daySessions = box.get(date, defaultValue: {});
        daySessions[sessionId] = newSessionData;
        await box.put(date, daySessions);
        registerReminder(type: 'sessions', itemId: sessionId, itemData: newSessionData, reminderDate: date);
      }

      handleFilesCloud(tableId, newSessionData);
      syncToCloud(tableId: tableId, where: 'sessions', action: 'sc', itemId: sessionId, isNew: true, dates: selectedDates, data: {sessionId: newSessionData});
    } else {
      showToast(0, message);
    }
    //
    //
    //
  } catch (e) {
    showToast(0, 'Could not create session');
    errorPrint('create-session', e);
  }
}
