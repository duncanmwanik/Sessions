import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_helpers/pending/pending_actions.dart';
import '../../../_helpers/user/user_actions.dart';
import '../../../_helpers/user/user_info.dart';
import '../../../_services/cloud/checks.dart';
import '../../../_services/cloud/firebase_database.dart';
import '../../../_widgets/components/toast.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import 'select_table.dart';

Future<void> deleteTable({required String tableId, required String tableName}) async {
  try {
    //
    // Confirm deletion with user
    //
    await showConfirmationDialog(
      title: 'Delete table <b>$tableName</b>?',
      yeslabel: 'Delete',
      content: 'You will lose all saved data. The table will be removed from other user devices when they open it next time.',
    ).then((deleteYeah) async {
      // If user confirms delete
      if (deleteYeah == true) {
        String userId = getCurrentUserId();
        //
        // Check if user is the table's owner
        //
        await isTableOwnerFirebase(tableId, userId).then((value) async {
          if (value) {
            // delete table from cloud
            await cloudService.deleteData('$tablesPathCloud/$tableId');
            // remove table from local and cloud user data
            await removeTableFromUserTableData(userId, tableId);
            // unselect table if it was the app-wide selectesd table
            await unSelectTable(tableId);
            //
          } else {
            // Alert user they don't have teh priviledge to delete the table
            // *Note this point is not expected to be reached as the buttons to delete
            // the table should only be available for table owner
            showToast(0, 'Only table owner can delete table');
            //
          }
        });
      }
    });
  } catch (e) {
    errorPrint('delete-table', e);
    showToast(0, 'Could not delete table');
    await addToPendingActions(tableId: tableId, where: 'user', action: 'd', data: {'tableName': tableName});
  }
}

Future<void> removeTable({required String tableId, required String tableName}) async {
  try {
    // Removes a table from non-table owners
    // Confirm for removal
    //
    await showConfirmationDialog(
      title: 'Remove table <b>$tableName</b>?',
      yeslabel: 'Remove',
      content: 'The table will be completely removed from all your devices.',
    ).then((deleteYeah) async {
      // If user confirms removal
      if (deleteYeah == true) {
        // Prevent table owners from removing their own tables, they can only delete them
        // *Not expected to be reached as the remove table button should be hidden from table owners
        await isTableOwnerFirebase(tableId, getCurrentUserId()).then((isTableOwner) async {
          if (!isTableOwner) {
            // remove table from local and cloud user data
            await removeTableFromUserTableData(getCurrentUserId(), tableId);
            // unselect table if it was the app-wide selectesd table
            await unSelectTable(tableId);
            //
          }
          //
          else {
            showToast(0, 'You cannot remove a table you created. Delete the table instead.');
          }
        });
      }
    });
  } catch (e) {
    errorPrint('remove-table', e);
    showToast(0, 'Could not remove table');
  }
}

Future<void> removeMissingTable({required String tableId}) async {
  try {
    //
    // If the table data from the cloud is missing, it has been deleted by it's owner
    // So we remove the table form all other users still having the table
    //
    showToast(2, 'Table has been deleted.');
    //
    // remove table from local and cloud user data
    await removeTableFromUserTableData(getCurrentUserId(), tableId);
    // unselect table if it was the app-wide selectesd table
    await unSelectTable(tableId);
    //
  } catch (e) {
    errorPrint('delete-table', e);
    showToast(2, 'Missing table should be removed.');
  }
}
