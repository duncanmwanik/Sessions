import 'package:hive_flutter/hive_flutter.dart';

import '../../../../features/_tables/_helpers/get_table_data.dart';

Map notificationTypes = {'z': 'table', 's': 'sessions', 'c': 'chat', 'b': 'lists', 'n': 'notes', 't': 'tasks', 'e': 'explore'};

bool isNotificationAllowed(String type) {
  try {
    return Hive.box('${currentSelectedTable()}_notifications').get(notificationTypes[type], defaultValue: false);
  } catch (e) {
    return false;
  }
}
