import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_helpers/_common_helpers/internet_connection.dart';
import '../../_helpers/activity/log_activity.dart';
import '../../_helpers/pending/pending_actions.dart';
import '../../features/_tables/_helpers/get_table_data.dart';
import 'firebase_database.dart';

Future<bool> syncToCloud({
  required String tableId,
  required String where,
  required String action,
  required Map data,
  String itemId = '',
  bool isNew = false,
  bool isEdit = false,
  bool isDelete = false,
  String editedItems = '',
  String label = '',
  String flag = '',
  String color = '',
  String listId = '',
  List dates = const [],
}) async {
  //
  // Check for an active internet connection
  //
  await hasAccessToInternet().then((hasInternet) async {
    if (hasInternet) {
      //
      print('sync: $editedItems');
      print('sync data: $data');
      //
      await syncTableData(
        tableId: currentSelectedTable(),
        where: where,
        action: action,
        data: data,
        itemId: itemId,
        isNew: isNew,
        isEdit: isEdit,
        isDelete: isDelete,
        editedItems: editedItems,
        label: label,
        flag: flag,
        color: color,
        listId: listId,
        dates: dates,
      );

      return true;
      //
      //
      //
    }
    //
    // if there is no active internet connection
    // we add the sync action to pending actions
    //
    else {
      await addToPendingActions(
        tableId: currentSelectedTable(),
        where: where,
        action: action,
        isNew: isNew,
        isEdit: isEdit,
        isDelete: isDelete,
        itemId: itemId,
        items: editedItems,
        data: data,
        dates: dates,
        label: label,
        flag: flag,
        color: color,
        listId: listId,
      );

      return false;
    }

    //
    //
    //
  });

  return false;
}

Future<bool> syncTableData({
  required String tableId,
  required String where,
  required String action,
  required Map data,
  String itemId = '',
  bool isNew = false,
  bool isEdit = false,
  bool isDelete = false,
  String editedItems = '',
  String label = '',
  String flag = '',
  String color = '',
  String listId = '',
  List dates = const [],
}) async {
  try {
    //
    // Check for an active internet connection
    //
    hasAccessToInternet().then((hasInternet) async {
      if (hasInternet) {
        print('sync: $editedItems');
        print('sync data: $data');
        //
        String currentTablePath = '$tablesPathCloud/$tableId';
        //
        //
        // --------------------------------------------------------------------------
        // New stuff/ Creation
        //
        //
        if (isNew) {
          //
          // creating a table
          //
          if (action == 'zc') {
            await cloudService.writeData('$currentTablePath/admins', {editedItems: '1'});
            await cloudService.writeData('$currentTablePath/activity', {'latest': '1'});
            await cloudService.writeData(currentTablePath, data);
          }
          //
          // creating a list item
          //
          else if (action == 'ic') {
            await cloudService.writeData('$currentTablePath/$where/$listId/i', data);
          }
          //
          // creating, copying or moving a session
          //
          else if (['sc', 'ss'].contains(action)) {
            for (String date in dates) {
              await cloudService.writeData('$currentTablePath/$where/$date', data);
            }
          }
          //
          // everything else: creating notes, tasks, lists
          //
          else {
            await cloudService.writeData('$currentTablePath/$where', data);
          }
          //
          //
        }
        //
        //
        // --------------------------------------------------------------------------
        // Editing stuff
        //
        //
        else if (isEdit) {
          //
          // items is a string list of the edits made to a nte, task, session etc.
          // if item starts with 'i' : it's a task entry
          // if item starts with 'd' : the item as been deleted
          //
          getSplitList(editedItems).forEach((editedItem) async {
            bool isAddTaskEntry = editedItem.startsWith('i');
            bool isDeleteTaskEntry = editedItem.startsWith('k');
            bool isDelete = editedItem.startsWith('d');
            String deleteKey = isDelete ? editedItem.split('/')[1] : editedItem;
            String addTaskEntrykey = isAddTaskEntry ? editedItem.split('/')[1] : editedItem;
            String deleteTaskEntrykey = isDeleteTaskEntry ? editedItem.split('/')[1] : editedItem;

            //
            //  editing or deleting task entry
            //
            if (isAddTaskEntry) {
              await cloudService.writeData('$currentTablePath/$where/$itemId/i', {addTaskEntrykey: data['i'][addTaskEntrykey] ?? {}});
            }
            //
            else if (isDeleteTaskEntry) {
              await cloudService.deleteData('$currentTablePath/$where/$itemId/i/$deleteTaskEntrykey');
            }
            //
            //
            //
            else {
              //
              // editing table
              //
              if (action == 'ze') {
                if (isDelete) {
                  await cloudService.deleteData('$currentTablePath/$where/$deleteKey');
                } else {
                  await cloudService.writeData('$currentTablePath/$where', {editedItem: data[editedItem] ?? ''});
                }
              }
              //
              // editing session
              //
              else if (action == 'se') {
                if (isDelete) {
                  await cloudService.deleteData('$currentTablePath/$where/${dates.first}/$itemId/$deleteKey');
                } else {
                  await cloudService.writeData('$currentTablePath/$where/${dates.first}/$itemId', {editedItem: data[editedItem] ?? ''});
                }
              }
              //
              // editing list item
              //
              else if (action == 'ie') {
                if (isDelete) {
                  await cloudService.deleteData('$currentTablePath/$where/$listId/i/$itemId/$deleteKey');
                } else {
                  await cloudService.writeData('$currentTablePath/$where/$listId/i/$itemId', {editedItem: data[editedItem] ?? ''});
                }
              }
              //
              // all others
              //
              else {
                if (isDelete) {
                  await cloudService.deleteData('$currentTablePath/$where/$itemId/$deleteKey');
                } else {
                  await cloudService.writeData('$currentTablePath/$where/$itemId', {editedItem: data[editedItem] ?? ''});
                }
              }
              //
              //
              //
            }
          });
        }
        //
        //
        // --------------------------------------------------------------------------
        // Deleting items: Session/Note/Task/List
        //
        //
        else if (isDelete) {
          //
          // a list item
          //
          if (action == 'id') {
            await cloudService.deleteData('$currentTablePath/$where/$listId/i/$itemId');
          }
          //
          // deleting a session on a particular date
          //
          else if (action == 'sd') {
            await cloudService.deleteData('$currentTablePath/$where/${dates.first}/$itemId');
          }
          //
          // all others
          //
          else {
            await cloudService.deleteData('$currentTablePath/$where/$itemId');
          }
          //
          //
        }
        //
        //
        // --------------------------------------------------------------------------
        // Update all other users by updating the cloud table activity version
        // which they are listening to, prompting an update of data from the
        // cloud on their ends.
        //
        await ActivityLogger().logActivity(
          where: where,
          action: action,
          itemId: itemId,
          items: editedItems,
          dates: dates.join('|'),
          label: label,
          flag: flag,
          color: color,
          listId: listId,
        );
        // --------------------------------------------------------------------------
        //
        // End of sync
      }
      //
      // if there is no active internet connection
      // we add the sync action to pending actions
      //
      else {
        await addToPendingActions(
          tableId: currentSelectedTable(),
          where: where,
          action: action,
          isNew: isNew,
          isEdit: isEdit,
          isDelete: isDelete,
          itemId: itemId,
          items: editedItems,
          data: data,
          dates: dates,
          label: label,
          flag: flag,
          color: color,
          listId: listId,
        );
      }
      //
      //
    });
    //
    // return success
    //
    return true;
    //
    //
  } catch (e) {
    //
    // If syncing to cloud fails (), we add the sync action to pending actions for retries.
    //
    await addToPendingActions(
      tableId: currentSelectedTable(),
      where: where,
      action: action,
      isNew: isNew,
      isEdit: isEdit,
      isDelete: isDelete,
      itemId: itemId,
      items: editedItems,
      data: data,
      dates: dates,
      label: label,
      flag: flag,
      color: color,
      listId: listId,
    );
    //
    // Log an error to analytics or dev
    errorPrint('sync-$where-$action', e);
    //
    //
    return false; // return a fail
    //
    //
  }
}
