import 'package:sessions/_helpers/_common_helpers/global_helper.dart';
import 'package:sessions/_helpers/date_time/reminders.dart';

List getReminderList(String reminderString) {
  try {
    List reminderList = [];
    getSplitList(reminderString).forEach((reminder) {
      String reminderNo = reminder.toString().split('.')[0];
      String reminderPeriod = reminder.toString().split('.')[1];

      reminderList.add('$reminderNo ${reminderPeriodsMap[reminderPeriod]}');
    });

    return reminderList;
  } catch (e) {
    return [];
  }
}
