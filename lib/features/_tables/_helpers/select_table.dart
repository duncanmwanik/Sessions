import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sessions/_providers/_provider_variables.dart';
import 'package:sessions/_variables/navigation_variables.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_widgets/components/snackbar.dart';
import '../../../_widgets/components/toast.dart';
import 'get_table_data.dart';
import 'update_all_table_data.dart';
import 'update_table_data.dart';

Future<void> selectNewTable(String tableId, {String? newUserId}) async {
  try {
    // if the chosen table is not the currently selected table
    if (tableId != currentSelectedTable()) {
      // we clear any item selection from previous table
      itemSelectionProviderX.clearAnyItemSelections();

      // we load all boxes for the chosen table
      await Hive.openBox(tableId);
      await Hive.openBox('${tableId}_info');
      await Hive.openBox('${tableId}_admins');
      await Hive.openBox('${tableId}_activity');
      await Hive.openBox('${tableId}_history');
      await Hive.openBox('${tableId}_chats');
      await Hive.openBox('${tableId}_notes');
      await Hive.openBox('${tableId}_tasks');
      await Hive.openBox('${tableId}_lists');
      await Hive.openBox('${tableId}_notifications');
      await Hive.openBox('${tableId}_labels');
      await Hive.openBox('${tableId}_flags');

      // we update the current selected table id to the chosen table
      await updateSelectedTableId(tableId, newUserId: newUserId);
      // we restart view at home screen again
      // so as to run the initState function in home screen
      if (newUserId == null) {
        homeX.currentContext!.go('/');

        closeDrawerIfOpened();

        // if there is no table data saved locally
        // we fetch the data from cloud
        if (getLastTableActivityVersion(tableId) == 'none') {
          showSnackBar('Loading table...');
          await updateAllTableData(tableId, isFirstTime: true);
        }
      }
    } else {
      // if the chosen table is already selected, we just close the drawer if opened
      closeDrawerIfOpened();
    }
  } catch (e) {
    showToast(0, 'Could not load table');
    errorPrint('select-table', e);
  }
}

Future<void> unSelectTable(String tableId) async {
  if (currentSelectedTable() == tableId) {
    await updateSelectedTableId('none');
  }
}
