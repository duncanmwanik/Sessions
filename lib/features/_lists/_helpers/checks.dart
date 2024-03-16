String validateListInput(String? title) {
  if (title == null || title.trim().isEmpty) {
    return 'Enter list title';
  } else {
    return '';
  }
}
