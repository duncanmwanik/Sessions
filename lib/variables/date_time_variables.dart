// list of days of the week objects
import '../models/dates_model.dart';

List<DayObject> weekDaysList = [
  const DayObject(dayNumber: 0, dayName: 'Sunday', dayShortName: 'S'),
  const DayObject(dayNumber: 1, dayName: 'Monday', dayShortName: 'M'),
  const DayObject(dayNumber: 2, dayName: 'Tuesday', dayShortName: 'T'),
  const DayObject(dayNumber: 3, dayName: 'Wednesday', dayShortName: 'W'),
  const DayObject(dayNumber: 4, dayName: 'Thursday', dayShortName: 'T'),
  const DayObject(dayNumber: 5, dayName: 'Friday', dayShortName: 'F'),
  const DayObject(dayNumber: 6, dayName: 'Saturday', dayShortName: 'S'),
];

// all months
const List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

// converts 24hrs ti 12 hour clock version

const Map<int, String> hours24to12 = {
  0: "12:00 AM",
  1: "1:00 AM",
  2: "2:00 AM",
  3: "3:00 AM",
  4: "4:00 AM",
  5: "5:00 AM",
  6: "6:00 AM",
  7: "7:00 AM",
  8: "8:00 AM",
  9: "9:00 AM",
  10: "10:00 AM",
  11: "11:00 AM",
  12: "12:00 PM",
  13: "1:00 PM",
  14: "2:00 PM",
  15: "3:00 PM",
  16: "4:00 PM",
  17: "5:00 PM",
  18: "6:00 PM",
  19: "7:00 PM",
  20: "8:00 PM",
  21: "9:00 PM",
  22: "10:00 PM",
  23: "11:00 PM",
};

// Map<int, int> hours12to24 = hours24to12.map((k, v) => MapEntry(v, k));
