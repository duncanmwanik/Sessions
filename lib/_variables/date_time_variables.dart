// list of days of the week objects
import 'package:flutter/material.dart';

// day object
class DayObject {
  const DayObject({required this.number, required this.name, required this.shortName, required this.shortNameCap, required this.superShortName});
  final int number;
  final String name;
  final String shortName;
  final String shortNameCap;
  final String superShortName;
}

const List<DayObject> weekDaysList = [
  DayObject(number: 0, name: 'Sunday', shortName: 'Sun', shortNameCap: 'SUN', superShortName: 'S'),
  DayObject(number: 1, name: 'Monday', shortName: 'Mon', shortNameCap: 'MON', superShortName: 'M'),
  DayObject(number: 2, name: 'Tuesday', shortName: 'Tue', shortNameCap: 'TUE', superShortName: 'T'),
  DayObject(number: 3, name: 'Wednesday', shortName: 'Wed', shortNameCap: 'WED', superShortName: 'W'),
  DayObject(number: 4, name: 'Thursday', shortName: 'Thu', shortNameCap: 'THU', superShortName: 'T'),
  DayObject(number: 5, name: 'Friday', shortName: 'Fri', shortNameCap: 'FRI', superShortName: 'F'),
  DayObject(number: 6, name: 'Saturday', shortName: 'Sat', shortNameCap: 'SAT', superShortName: 'S'),
];

// all months
const List<String> monthNamesList = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
const List<String> monthNamesListShort = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

// converts 24hrs to 12 hour clock version
const Map<int, String> hours24to12ConversionMap = {0: '12', 13: '1', 14: '2', 15: '3', 16: '4', 17: '5', 18: '6', 19: '7', 20: '8', 21: '9', 22: '10', 23: '11'};

const Map<int, String> hours24to12LabelShort = {
  0: '12',
  1: '1',
  2: '2',
  3: '3',
  4: '4',
  5: '5',
  6: '6',
  7: '7',
  8: '8',
  9: '9',
  10: '10',
  11: '11',
  12: '12',
  13: '1',
  14: '2',
  15: '3',
  16: '4',
  17: '5',
  18: '6',
  19: '7',
  20: '8',
  21: '9',
  22: '10',
  23: '11'
};

const Map<int, String> hours24to12Periods = {
  0: 'AM',
  1: 'AM',
  2: 'AM',
  3: 'AM',
  4: 'AM',
  5: 'AM',
  6: 'AM',
  7: 'AM',
  8: 'AM',
  9: 'AM',
  10: 'AM',
  11: 'AM',
  12: 'PM',
  13: 'PM',
  14: 'PM',
  15: 'PM',
  16: 'PM',
  17: 'PM',
  18: 'PM',
  19: 'PM',
  20: 'PM',
  21: 'PM',
  22: 'PM',
  23: 'PM'
};

const Map<int, String> dayEndScript = {
  1: 'st',
  2: 'nd',
  3: 'rd',
  4: 'th',
  5: 'th',
  6: 'th',
  7: 'th',
  8: 'th',
  9: 'th',
  10: 'th',
  11: 'th',
  12: 'th',
  13: 'th',
  14: 'th',
  15: 'th',
  16: 'th',
  17: 'th',
  18: 'th',
  19: 'th',
  20: 'th',
  21: 'st',
  22: 'nd',
  23: 'rd',
  24: 'th',
  25: 'th',
  26: 'th',
  27: 'th',
  28: 'th',
  29: 'th',
  30: 'th',
  31: 'st',
};

const List<IconData> dayViewIcons = [Icons.view_day_rounded, Icons.view_week_rounded, Icons.date_range_rounded];
const List<String> dayViewLabels = ['Day', 'Week', 'Month'];
