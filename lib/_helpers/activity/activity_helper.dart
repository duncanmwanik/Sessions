import '../date_time/date_info.dart';
import '../date_time/datetime_helper.dart';

String getActivityDateTime(String timestamp) {
  try {
    String date = DateTime.fromMicrosecondsSinceEpoch(int.parse(timestamp)).toString();

    return '${getDayInfo(date.split(' ')[0])} at ${get12HourTimeFrom24HourTime(date.split(' ')[1])}';
  } catch (e) {
    return 'Recently';
  }
}
