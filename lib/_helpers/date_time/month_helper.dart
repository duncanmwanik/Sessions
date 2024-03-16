import 'datetime_helper.dart';

Map<int, String> getMonthDateMap(int year, int month) {
  Map<int, String> monthDatesMap = {};
  DateTime firstDay = DateTime.utc(year, month, 1);
  int firstDateIndex = firstDay.weekday;
  for (int i = firstDateIndex; i > 0; i--) {
    monthDatesMap[firstDateIndex - i] = getDatePartFromDateTime(firstDay.subtract(Duration(days: i)));
  }
  int remainingDays = 42 - monthDatesMap.length;
  for (int i = 0; i < remainingDays; i++) {
    monthDatesMap[monthDatesMap.length] = getDatePartFromDateTime(firstDay.add(Duration(days: i)));
  }

  return monthDatesMap;
}

Future<Map<int, Map<int, String>>> getAllMonthsDateMap(int year) async {
  Map<int, Map<int, String>> monthsDateMap = {};

  Future.microtask(() {
    for (int i = 0; i < 12; i++) {
      monthsDateMap[i] = getMonthDateMap(year, i + 1);
    }
  });

  return monthsDateMap;
}
