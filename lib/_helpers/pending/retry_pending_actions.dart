import 'dart:async';

import 'package:sessions/_helpers/user/user_sync.dart';

import '../../_services/cloud/sync_to_cloud.dart';
import '../../_services/hive/local_storage_service.dart';
import '../_common_helpers/internet_connection.dart';

//
//
// We retry each pending actions every 5 minutes in the backgound.
// This is initiated in the 'Home Screen'.
//
void retryPendingActions() {
  hasAccessToInternet().then((hasInternet) async {
    if (hasInternet) {
      Timer.periodic(Duration(seconds: 45), (Timer timer) {
        pendingTableBox.toMap().forEach((pendingId, syncAction) async {
          //
          // If it's for user data
          //
          if (syncAction['where'] == 'user') {
            syncUserData(
              userId: syncAction['userId'],
              action: syncAction['action'],
              itemId: syncAction['itemId'],
              groupName: syncAction['groupName'],
              groupList: syncAction['groupList'],
            ).then((successful) {
              print('.......Pending Action [ ${syncAction['where']} : $pendingId : $syncAction ] successful');
              if (successful) {
                //
                // we remove the sync action if it has been retried successsfully
                //
                pendingTableBox.delete(pendingId);
              } else {
                //
                // else it stays, to be retried again
                // TODO: maybe we should add a max retry number to avoid infinity loops
                //
                print('.......Pending Action [ $pendingId : $syncAction ] failed');
              }
            });
          }
          //
          // If it's for table data
          //
          else {
            await syncTableData(
              tableId: syncAction['tableId'],
              where: syncAction['where'],
              action: syncAction['action'],
              data: syncAction['data'],
              itemId: syncAction['itemId'],
              isNew: syncAction['isNew'],
              isEdit: syncAction['isEdit'],
              isDelete: syncAction['isDelete'],
              editedItems: syncAction['items'],
              label: syncAction['label'],
              flag: syncAction['flag'],
              color: syncAction['color'],
              listId: syncAction['listId'],
              dates: syncAction['dates'],
            ).then((successful) {
              print('.......Pending Action [ $pendingId : $syncAction ] successful');
              if (successful) {
                //
                // we remove the sync action if it has been retried successsfully
                //
                pendingTableBox.delete(pendingId);
              } else {
                //
                // else it stays, to be retried again
                // TODO: maybe we should add a max retry number to avoid infinity loops
                //
                print('.......Pending Action [ $pendingId : $syncAction ] failed');
              }
            });
          }
        });
      });
    } else {
      //
      //
      //
    }
  });
}
