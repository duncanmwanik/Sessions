List<DateTime> getCurrentWeekDates(DateTime date) {
  int dateNo = date.weekday;

  if (dateNo == 1) {
    return [
      date.subtract(Duration(days: 1)),
      date,
      date.add(Duration(days: 1)),
      date.add(Duration(days: 2)),
      date.add(Duration(days: 3)),
      date.add(Duration(days: 4)),
      date.add(Duration(days: 5)),
    ];
  }
  if (dateNo == 2) {
    return [
      date.subtract(Duration(days: 2)),
      date.subtract(Duration(days: 1)),
      date,
      date.add(Duration(days: 1)),
      date.add(Duration(days: 2)),
      date.add(Duration(days: 3)),
      date.add(Duration(days: 4)),
    ];
  }
  if (dateNo == 3) {
    return [
      date.subtract(Duration(days: 3)),
      date.subtract(Duration(days: 2)),
      date.subtract(Duration(days: 1)),
      date,
      date.add(Duration(days: 1)),
      date.add(Duration(days: 2)),
      date.add(Duration(days: 3)),
    ];
  }
  if (dateNo == 4) {
    return [
      date.subtract(Duration(days: 4)),
      date.subtract(Duration(days: 3)),
      date.subtract(Duration(days: 2)),
      date.subtract(Duration(days: 1)),
      date,
      date.add(Duration(days: 1)),
      date.add(Duration(days: 2)),
    ];
  }
  if (dateNo == 5) {
    return [
      date.subtract(Duration(days: 5)),
      date.subtract(Duration(days: 4)),
      date.subtract(Duration(days: 3)),
      date.subtract(Duration(days: 2)),
      date.subtract(Duration(days: 1)),
      date,
      date.add(Duration(days: 1)),
    ];
  }
  if (dateNo == 6) {
    return [
      date.subtract(Duration(days: 6)),
      date.subtract(Duration(days: 5)),
      date.subtract(Duration(days: 4)),
      date.subtract(Duration(days: 3)),
      date.subtract(Duration(days: 2)),
      date.subtract(Duration(days: 1)),
      date,
    ];
  }
  if (dateNo == 7) {
    return [
      date,
      date.add(Duration(days: 1)),
      date.add(Duration(days: 2)),
      date.add(Duration(days: 3)),
      date.add(Duration(days: 4)),
      date.add(Duration(days: 5)),
      date.add(Duration(days: 6)),
    ];
  }

  return [];
}
