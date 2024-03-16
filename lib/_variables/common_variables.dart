import 'package:flutter/material.dart';

List navBatItems = ['Sessions', 'Notes & Tasks', 'Boards', 'Chat', 'Explore'];

const List<String> sessionTypeList = [
  'Session',
  'Class',
  'Lecture',
  'Meeting',
  'Appointment',
  'Lab',
  'Fieldwork',
  'Test',
  'Exam',
  'Assignment',
  'Tutorial',
  'Task',
  'Workout',
  'Rest',
  'Wellness',
  'Entertainment',
  'Travel',
  'Adventure',
  'Chore',
  'Meal',
  'Hang Out',
];

class ColorObject {
  const ColorObject({required this.color, required this.textColor});
  final Color color;
  final Color textColor;
}

const List<ColorObject> sessionColorList = [
  ColorObject(color: Colors.blue, textColor: Colors.white),
  ColorObject(color: Colors.red, textColor: Colors.white),
  ColorObject(color: Colors.green, textColor: Colors.white),
  ColorObject(color: Colors.orange, textColor: Colors.white),
  ColorObject(color: Colors.purple, textColor: Colors.white),
  ColorObject(color: Colors.pink, textColor: Colors.white),
  ColorObject(color: Colors.yellow, textColor: Colors.black87),
  ColorObject(color: Colors.brown, textColor: Colors.white),
];

Map<String, ColorObject> flagColors = {
  '0': ColorObject(color: Colors.red, textColor: Colors.white),
  '1': ColorObject(color: Colors.green, textColor: Colors.white),
  '2': ColorObject(color: Colors.blue, textColor: Colors.white),
  '3': ColorObject(color: Colors.amber, textColor: Colors.black),
  '4': ColorObject(color: Colors.yellow, textColor: Colors.black),
  '5': ColorObject(color: Colors.purple, textColor: Colors.white),
  '6': ColorObject(color: Colors.orange, textColor: Colors.white),
  '7': ColorObject(color: Colors.brown, textColor: Colors.white),
  '8': ColorObject(color: Colors.teal, textColor: Colors.black),
  '9': ColorObject(color: Colors.lime, textColor: Colors.black),
  '10': ColorObject(color: Colors.deepOrange, textColor: Colors.white),
  '11': ColorObject(color: Colors.lightGreen, textColor: Colors.black),
  '12': ColorObject(color: Colors.lightBlue, textColor: Colors.black),
  '13': ColorObject(color: Colors.indigo, textColor: Colors.white),
  '14': ColorObject(color: Colors.deepPurple, textColor: Colors.white),
  '15': ColorObject(color: Colors.cyan, textColor: Colors.black),
  '16': ColorObject(color: Colors.grey, textColor: Colors.white),
  '17': ColorObject(color: Colors.deepOrangeAccent, textColor: Colors.white),
  '18': ColorObject(color: Colors.orangeAccent, textColor: Colors.white),
  '19': ColorObject(color: Colors.greenAccent, textColor: Colors.white),
  '20': ColorObject(color: Colors.blueGrey, textColor: Colors.white),
  '21': ColorObject(color: Colors.yellowAccent, textColor: Colors.black),
  '22': ColorObject(color: Colors.purpleAccent, textColor: Colors.black),
  '23': ColorObject(color: Colors.amberAccent, textColor: Colors.black),
  '24': ColorObject(color: Colors.cyanAccent, textColor: Colors.black),
  '25': ColorObject(color: Colors.pinkAccent, textColor: Colors.black),
  '26': ColorObject(color: Colors.limeAccent, textColor: Colors.black),
};

Map<String, Color> itemBgColors = {
  'x': Colors.transparent,
  '0': Colors.amber.shade100,
  '1': Colors.red.shade100,
  '2': Colors.green.shade100,
  '3': Colors.blue.shade100,
  '4': Colors.purple.shade100,
  '5': Colors.brown.shade100,
  '6': Colors.orange.shade100,
  '7': Colors.deepOrange.shade100,
  '8': Colors.cyan.shade100,
};

Map activityTypes = {
  'c': 'created',
  'e': 'edited',
  'd': 'deleted',
  's': 'copied',
  'm': 'moved',
};

Map extraActions = {'p': 'pin', 'a': 'archive', 'c': 'change color for'};

const int sessionsViewNo = 0;
const int notesViewNo = 1;
const int listsViewNo = 2;
const int chatViewNo = 3;
const int exploreViewNo = 4;

const int sessionsViewDailyNo = 0;
const int sessionsViewWeeklyNo = 1;
const int sessionsViewMonthlyNo = 2;
const int sessionsViewYearlyNo = 3;

Map specialLabelsIcons = {'Trash': Icons.auto_delete_rounded, 'Archive': Icons.archive_rounded, 'All': Icons.label_rounded};

const double webMaxWidth = 768.0;
const double webMinWidth = 250.0;
const double webMaxTableManagerWidth = 300.0;
const double webMaxDialogWidth = 400.0;
const double webMaxDialogHeight = 500;
const double webMinDialogWidth = 150;
const double webMinDialogHeight = 300;
const double webMaxButtonWidth = 300.0;
const double webMaxButtonHeight = 50.0;
const double webMaxListWidth = 200.0;
const double webMaxToastWidth = 500.0;

// Each layout type shows the icon whose layout will be toggled next
Map<String, IconData> iconLayoutBoard = {'grid': Icons.view_agenda_outlined, 'row': Icons.view_column, 'column': Icons.grid_view_outlined};
Map<String, IconData> iconLayoutNotes = {'grid': Icons.view_agenda_outlined, 'row': Icons.grid_view_outlined};

Map typeActionsEdit = {'notes': 'ne', 'tasks': 'te', 'lists': 'be'};
Map typeActionsDelete = {'notes': 'nd', 'tasks': 'td', 'lists': 'bd'};

List<String> sessionViews = ['Day', 'Week', 'Month', 'Year', 'Timeline'];

Map<String, Color> pomoColors = {
  '0': Colors.red,
  '1': Colors.green,
  '2': Colors.blue,
  '3': Colors.amber,
  '4': Colors.yellow,
  '5': Colors.purple,
  '6': Colors.brown,
  '7': Colors.orange,
  '8': Colors.teal,
  '9': Colors.lime,
  '10': Colors.deepOrange,
  '11': Colors.lightGreen,
  '12': Colors.lightBlue,
  '13': Colors.indigo,
  '14': Colors.deepPurple,
  '15': Colors.cyan,
  '16': Colors.grey,
  '17': Colors.deepOrangeAccent,
  '18': Colors.orangeAccent,
  '19': Colors.greenAccent,
  '20': Colors.blueGrey,
  '21': Colors.yellowAccent,
  '22': Colors.purpleAccent,
  '23': Colors.amberAccent,
  '24': Colors.cyanAccent,
  '25': Colors.pinkAccent,
  '26': Colors.limeAccent,
};

Map<String, String> defaultPomodoroMap = {
  'focusTime': '5',
  'breakTime': '5',
  'longBreakTime': '10',
  'focusColor': '0',
  'breakColor': '1',
  'longBreakColor': '2',
  'autoPlay': '1',
  'longBreakInterval': '4',
  'alarmOn': '1',
  'alarmSound': '0',
};

Map<String, String> pomodoroTitles = {'focus': 'Focus', 'break': 'Break', 'longBreak': 'Long Break'};

List<String> themeImages = ['light', 'dark', 'mars', 'jupiter'];
