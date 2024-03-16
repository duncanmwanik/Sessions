bool isPinnedItem(String? value) {
  return value != null
      ? value == '1'
          ? true
          : false
      : false;
}
