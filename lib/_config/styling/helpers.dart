import 'package:sessions/_variables/common_variables.dart';

bool hasBGColor(String? bgColor) {
  if (bgColor == null || bgColor == 'x' || bgColor.isEmpty || !itemBgColors.containsKey(bgColor)) {
    return false;
  } else {
    return true;
  }
}
