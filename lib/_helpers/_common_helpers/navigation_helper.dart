import 'package:flutter/material.dart';

import '../../_providers/common_providers/datetime_provider.dart';
import '../../_variables/navigation_variables.dart';
import '../date_time/datetime_helper.dart';

void swipeToNewDay(DateTimeProvider dateProvider, {DragEndDetails? details, String direction = 'none'}) {
  if (direction == 'right' || (details != null && details.primaryVelocity! < 0)) {
    String newDate = getDatePartFromDateTime(DateTime.parse(dateProvider.selectedDate).add(Duration(days: 1)));
    dateProvider.updateSelectedDate(newDate);
  }
  if (direction == 'left' || (details != null && details.primaryVelocity! > 0)) {
    String newDate = getDatePartFromDateTime(DateTime.parse(dateProvider.selectedDate).subtract(Duration(days: 1)));
    dateProvider.updateSelectedDate(newDate);
  }
}

Future<void> swipeToNewWeek(DateTimeProvider dateProvider, {DragEndDetails? details, String direction = 'none'}) async {
  if (direction == 'right' || (details != null && details.primaryVelocity! < 0)) {
    dateProvider.updateCurrentWeekDates(dateProvider.currentWeekDates[6].add(Duration(days: 1)));
  }
  if (direction == 'left' || (details != null && details.primaryVelocity! > 0)) {
    dateProvider.updateCurrentWeekDates(dateProvider.currentWeekDates[0].subtract(Duration(days: 1)));
  }
}

Future<void> swipeToNewMonth(DateTimeProvider dateProvider, {DragEndDetails? details, String direction = 'none'}) async {
  if (direction == 'right' || (details != null && details.primaryVelocity! < 0)) {
    dateProvider.updateSelectedMonth('inc');
    await dateProvider.updateMonthDatesMap();
  }
  if (direction == 'left' || (details != null && details.primaryVelocity! > 0)) {
    dateProvider.updateSelectedMonth('dec');
    await dateProvider.updateMonthDatesMap();
  }
}

Future<void> swipeToNewYear(DateTimeProvider dateProvider, {DragEndDetails? details, String direction = 'none'}) async {
  if (direction == 'right' || (details != null && details.primaryVelocity! < 0)) {
    dateProvider.updateSelectedYear(dateProvider.selectedYear + 1);
  }
  if (direction == 'left' || (details != null && details.primaryVelocity! > 0)) {
    dateProvider.updateSelectedYear(dateProvider.selectedYear - 1);
  }
}

void slideInInfoHeader() {
  animateController.reset();
  animateController.forward();
}
