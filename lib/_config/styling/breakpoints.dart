import 'package:flutter/foundation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ---------- ---------- ----------

bool isPhone() {
  return 100.w <= 500;
}

bool isNotPhone() {
  return 100.w > 500;
}

// ---------- ---------- ----------

bool isTabAndBelow() {
  return 100.w <= 768;
}

// ---------- ---------- ----------

bool isSmallPC() {
  return 100.w > 768;
}

// ---------- ---------- ----------

bool isLargePC() {
  return 100.w > 1200;
}

// ---------- ---------- ----------

bool showWebNavBox() {
  return 100.w >= 768;
}

bool showWebBox() {
  return kIsWeb && 100.w >= 1352;
}

// ---------- ---------- ----------
bool showSheetAsDialog() {
  return 100.w > 670;
}
