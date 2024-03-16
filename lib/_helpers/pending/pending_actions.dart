import 'dart:async';

import '../../_services/hive/local_storage_service.dart';
import '../_common_helpers/global_helper.dart';

Future<void> addToPendingActions({
  required String tableId,
  required String where,
  required String action,
  Map data = const {},
  String itemId = '',
  bool isNew = false,
  bool isEdit = false,
  bool isDelete = false,
  String items = '',
  String label = '',
  String flag = '',
  String color = '',
  String listId = '',
  List dates = const [],
  String userId = '',
  String groupName = '',
  List groupList = const [],
}) async {
  String pendingActionId = getUniqueId();
  if (where == 'chats') {
    pendingActionId = itemId;
  }

  await pendingTableBox.put(pendingActionId, {
    'tableId': tableId,
    'where': where,
    'action': action,
    'data': data,
    'itemId': itemId,
    'isNew': isNew,
    'isEdit': isEdit,
    'isDelete': isDelete,
    'items': items,
    'label': label,
    'flag': flag,
    'color': color,
    'listId': listId,
    'dates': dates,
    'userId': userId,
    'groupList': groupList,
    'groupName': groupName,
  });
  print('New pending action: $pendingActionId > $where $action $items : $itemId');
}

// remove this
bool isPendingItem(String id) {
  try {
    return pendingTableBox.containsKey(id);
  } catch (e) {
    return false;
  }
}

void removeFromPendingActions(String id) {
  pendingTableBox.delete(id);
  print('Removed pending action: $id');
}
