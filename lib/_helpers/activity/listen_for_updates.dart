import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../../_services/cloud/firebase_database.dart';
import '../../_widgets/components/toast.dart';
import '../../features/_tables/_helpers/delete_table.dart';
import '../../features/_tables/_helpers/get_table_data.dart';
import '../../features/_tables/_helpers/update_all_table_data.dart';
import 'get_new_activities.dart';

StreamSubscription<DatabaseEvent>? listenForNewActivity() {
  try {
    String currentTableId = currentSelectedTable();
    if (currentTableId != 'none') {
      return FirebaseDatabase.instance.ref().child('$tablesPathCloud/$currentTableId/activity/latest').onValue.listen((event) async {
        if (event.snapshot.value != null) {
          if (getLastTableActivityVersion(currentTableId) != 'none') {
            if (event.snapshot.value != getLastTableActivityVersion(currentTableId)) {
              await getNewActivities(currentTableId, getLastTableActivityVersion(currentTableId), event.snapshot.value as String);
            } else {}
          } else {
            updateAllTableData(currentTableId);
          }
        } else {
          showToast(0, 'Table is no longer available');
          removeMissingTable(tableId: currentTableId);
        }
      });
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}
