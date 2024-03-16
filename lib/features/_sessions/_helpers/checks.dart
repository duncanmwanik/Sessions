String validateNewSessionInput(String name, String startTime, List selectedDates) {
  if (name.trim().isEmpty) {
    return 'Enter session title';
  } else if (startTime.trim().isEmpty) {
    return 'Choose a start time';
  } else if (selectedDates.isEmpty) {
    return 'Select at least one date';
  } else {
    return '';
  }
}
