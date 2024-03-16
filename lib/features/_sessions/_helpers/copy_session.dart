import 'package:hive_flutter/hive_flutter.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_services/cloud/sync_to_cloud.dart';
import '../../../_widgets/components/snackbar.dart';
import '../../_tables/_helpers/get_table_data.dart';
import '../session_overview/_w/dialog_select_copy_date.dart';

void copySessionToDates({required String previousDate, required String sessionId, required Map sessionData, required bool move}) async {
  try {
    await showSelectCopyDatesDialog().then((newDates) async {
      if (newDates != null && newDates.isNotEmpty) {
        // close dialog
        popWhatsOnTop();
        closeBottomSheetIfOpen();

        showSnackBar('${move ? 'Moving' : 'Copying'} session to selected dates...');

        String tableId = currentSelectedTable();

        Box box = await Hive.openBox(tableId);
        for (String newDate in newDates) {
          Map daySessions = box.get(newDate, defaultValue: {});
          daySessions[sessionId] = sessionData;
          box.put(newDate, daySessions);
        }
        if (move) {
          Map daySessions = box.get(previousDate, defaultValue: {});
          daySessions.remove(sessionId);
          box.put(previousDate, daySessions);
        }

        syncToCloud(tableId: tableId, where: 'sessions', action: 'ss', itemId: sessionId, isNew: true, dates: newDates, data: {sessionId: sessionData});
        if (move) {
          syncToCloud(tableId: tableId, where: 'sessions', action: 'sd', itemId: sessionId, isDelete: true, dates: [previousDate], data: {});
        }
      }
    });

    //
    //
    //
  } catch (e) {
    errorPrint('${move ? 'move' : 'copy'}-session', e);
  }
}
