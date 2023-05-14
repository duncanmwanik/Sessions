import 'package:flutter/material.dart';

import '../variables/provider_variables.dart';

void selectNewDay(String newDay) async {
  int day = globalWatch.selectedDate;
  if (newDay == "NextDay") {
    day = day >= 6 ? 0 : day + 1;
  }
  if (newDay == "PreviousDay") {
    day = day <= 0 ? 6 : day - 1;
  }
  print(day);
  await globalWatch.selectNewDate(day);
}

void swipeToAnotherDay(DragEndDetails details) {
  if (details.primaryVelocity == null) {
    return;
  }
  if (details.primaryVelocity! < 0) {
    selectNewDay("NextDay");
  }
  if (details.primaryVelocity! > 0) {
    selectNewDay("PreviousDay");
  }
}
