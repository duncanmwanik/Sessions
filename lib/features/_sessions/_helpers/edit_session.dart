import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_helpers/edits/compare_data.dart';
import '../../../_providers/_provider_variables.dart';
import '../../../_services/cloud/sync_to_cloud.dart';
import '../../../_widgets/components/toast.dart';
import '../../_tables/_helpers/get_table_data.dart';
import '../../files/_helpers/upload_files.dart';
import '../../reminders/_helpers/register_reminder.dart';

String validateSessionInputEdit(String name, String startTime) {
  if (name.isEmpty) {
    return 'Enter session title';
  } else if (startTime.isEmpty) {
    return 'Choose session start time';
  } else {
    return '';
  }
}

Future<void> editSession(BuildContext context, Map editedSessionData, Map previousSessionData) async {
  String message = validateSessionInputEdit(editedSessionData['t'], editedSessionData['s']);
  if (message.isEmpty) {
    try {
      closeBottomSheetIfOpen();

      String sessionId = sessionProviderX.selectedSessionId;
      String selectedDate = dateTimeProviderX.selectedDate;
      String tableId = currentSelectedTable();

      // remove duplicate reminders
      editedSessionData['r'] = getJoinedList(getSplitList(editedSessionData['r']).toSet().toList());

      Map comparedData = compareData(type: 'sessions', previousData: previousSessionData, editedData: editedSessionData);
      String editedItems = comparedData['editedItems'];
      Map validatedData = comparedData['validatedData'];

      if (editedItems.isNotEmpty) {
        Box box = Hive.box(tableId);
        Map daySessions = box.get(selectedDate, defaultValue: {});
        daySessions[sessionId] = validatedData;
        await box.put(selectedDate, daySessions);

        registerReminder(type: 'sessions', itemId: sessionId, itemData: validatedData, reminderDate: selectedDate);

        handleFilesCloud(tableId, validatedData, items: editedItems);
        syncToCloud(tableId: tableId, where: 'sessions', action: 'se', itemId: sessionId, isEdit: true, editedItems: editedItems, dates: [selectedDate], data: validatedData);
      }
    } catch (e) {
      showToast(0, 'Could not edit session');
    }
  } else {
    showToast(0, message);
  }
}
