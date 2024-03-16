import 'package:awesome_notifications/awesome_notifications.dart';

import 'act_on_notification.dart';

@pragma('vm:entry-point')
Future<void> onActionReceivedMethod(ReceivedAction receivedAction) async {
  Map payload = receivedAction.payload as Map;
  await actOnNotificationData(payload);
}
