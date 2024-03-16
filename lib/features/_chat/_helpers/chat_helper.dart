import '../../../_variables/global_variables.dart';

// Future<void> retrySendingPendingMesages(String messageId, String message, String userName) async {
//   try {
//     String tableId = currentSelectedTable();
//     if (isPendingItem(messageId)) {
//       showOnUpdateLoader(true);

//       syncToCloud(tableId: tableId, where: 'chats', itemId: messageId, isNew: true, action: 'cc', data: {
//         messageId: json.encode({'u': userName, 'm': message})
//       });
//     }
//   } catch (e) {
//     //
//   } finally {
//     showOnUpdateLoader(false);
//   }
// }

void addToSendingChatsList({required String id}) async {
  sendingChatsList.add(id);
  // print('Sending chat item: $id');
}

void removeFromSendingChatsList({required String id}) async {
  sendingChatsList.remove(id);
  // print('Removing chat item: $id');
}
