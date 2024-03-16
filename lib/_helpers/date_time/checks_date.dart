import 'datetime_helper.dart';

bool doesCurrentWeekListContainToday(List currentWeekDates, DateTime today) {
  bool itContains = false;

  for (var date in currentWeekDates) {
    if (getDatePartFromDateTime(date) == getDatePartFromDateTime(today)) {
      itContains = true;
      break;
    }
  }

  return itContains;
}
