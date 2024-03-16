import 'date_info.dart';
import 'datetime_helper.dart';

Map reminderPeriodsMap = {'m': 'minutes', 'h': 'hours', 'd': 'days', 'w': 'weeks'};
Map periodMinutes = {'m': 1, 'h': 60, 'd': 1440, 'w': 10080};

String getFormattedReminder(String reminder) {
  try {
    String number = reminder.split('.')[0];
    String period = reminderPeriodsMap[reminder.split('.')[1]];
    return '$number $period before';
  } catch (e) {
    return '30 minutes before';
  }
}

String getFormattedReminderDateTime(String date, String time) {
  try {
    String time_ = getTimePartFromTimeOfDay(time);
    return '$date $time_';
  } catch (e) {
    return '';
  }
}

String getFormattedSingleReminder(String reminder) {
  try {
    String date = getDateInfoForReminder(reminder.split(' ')[0]);
    String time = get12HourTimeFrom24HourTime(reminder.split(' ')[1], islonger: true);
    return '$date, $time';
  } catch (e) {
    return '';
  }
}

int getReminderTimeInMinutes(String reminder) {
  try {
    int number = int.parse(reminder.split('.')[0]);
    int periodMinute = periodMinutes[reminder.split('.')[1]];
    return number * periodMinute;
  } catch (e) {
    return 30;
  }
}

bool hasReminderAlreadyPassed(String reminder) {
  try {
    return DateTime.parse(reminder).isBefore(DateTime.now());
  } catch (e) {
    return false;
  }
}
