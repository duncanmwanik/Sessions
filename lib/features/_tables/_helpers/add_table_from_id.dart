import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_helpers/_common_helpers/internet_connection.dart';
import '../../../_helpers/forms/regex_checks.dart';
import '../../../_helpers/user/user_actions.dart';
import '../../../_helpers/user/user_info.dart';
import '../../../_services/cloud/checks.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/components/toast.dart';
import 'checks_table.dart';

Future<void> addTableFromId(String tableId) async {
  try {
    if (tableId.isNotEmpty) {
      if (isValidTableId(tableId)) {
        hideKeyboard();
        showToast(2, 'Adding table...');

        if (!isTableAlreadyAdded(tableId)) {
          hasAccessToInternet().then((hasInternet) async {
            if (hasInternet) {
              await doesTableExist(tableId).then((tableName) async {
                if (tableName != 'none') {
                  await userDataBox.put(tableId, 0);
                  await tableNamesBox.put(tableId, tableName);

                  await addNewTableToUserTableData(getCurrentUserId(), tableId, []);
                  showToast(1, 'Added table $tableName');
                } else {
                  showToast(0, 'That table does not exist');
                }
              });
            }
          });
        } else {
          showToast(2, 'Table already added.');
        }
      } else {
        showToast(0, 'Enter a valid table id');
      }
    } else {
      showToast(0, 'Enter table id');
    }
  } catch (error) {
    showToast(0, 'Could not add table');
  }
}
