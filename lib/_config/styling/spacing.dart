import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sessions/_config/styling/breakpoints.dart';

import '../../_variables/common_variables.dart';

double webDrawerWidth() {
  return isPhone() ? 100.w : 400;
}

double calendarWidth() {
  return isNotPhone() ? 300 : 80.w;
}

double calendarHeight() {
  return isNotPhone() ? 300 : 80.w;
}

double weeklySessionHeight() {
  return 40;
}

double smallImageHeight() {
  return 25.h;
}

double imageHeight() {
  return kIsWeb ? 250 : 250;
}

double emptyImageHeight() {
  return kIsWeb ? 200 : 200;
}

double iconSize() {
  return 22;
}

double sessionBoxHeight() {
  if (isPhone()) {
    return 15;
  } else if (100.w > 500 && 100.w <= 640) {
    return 15;
  } else if (100.w > 640 && 100.w <= 710) {
    return 15;
  } else if (100.w > 710 && 100.w <= 768) {
    return 20;
  } else if (100.w > 768 && 100.w <= 1200) {
    return 20;
  } else if (100.w > 1200 && 100.w <= 1870) {
    return 20;
  } else if (100.w > 1870) {
    return 20;
  } else {
    return 15;
  }
}

int gridCount() {
  double width = 100.w;

  if (width >= 1650) {
    return 5;
  } else if (width >= 1200) {
    return 5;
  } else if (width >= 768) {
    return 3;
  } else {
    return 2;
  }
}

Size minSizeZero() {
  return Size(0, 0);
}

Size actionButtonMinSize() {
  return Size(150, 50);
}

Size actionButtonFixedSizes() {
  return Size(kIsWeb ? 30.w : 50.w, 50);
}

BoxConstraints webMaxConstraints() {
  return kIsWeb ? BoxConstraints(maxWidth: webMaxWidth) : BoxConstraints();
}

BoxConstraints webMaxDialogConstraints() {
  return kIsWeb ? BoxConstraints(maxWidth: webMaxDialogWidth, maxHeight: 60.h) : BoxConstraints();
}

//
//
// ---------- Width
//
//
double listItemWidth() {
  return kIsWeb ? 1.h : 6.w;
}

double borderWidths() {
  return 1.5;
}

double webAppBarWidth() {
  return webMaxWidth;
}

double maxChatWidth() {
  return kIsWeb ? 300 : 75.w;
}

double infinityWidth() {
  return double.maxFinite;
}

double largeWidth() {
  return 32;
}

double mediumWidth() {
  return 16;
}

double mediumSmallWidth() {
  return 12;
}

double smallWidth() {
  return 8;
}

double tinyWidth() {
  return 4;
}

//
//
// ---------- Height
//
//

double largeHeight() {
  return kIsWeb ? 48 : 5.h;
}

double semiLargeHeight() {
  return kIsWeb ? 32 : 4.h;
}

double mediumHeight() {
  return kIsWeb ? 16 : 3.h;
}

double mediumSmallHeight() {
  return kIsWeb ? 12 : 1.8.h;
}

double smallHeight() {
  return kIsWeb ? 8 : 1.h;
}

double tinyHeight() {
  return kIsWeb ? 4 : 0.3.h;
}

double largeHeightPlaceHolder() {
  return 10.h;
}

double smallHeightPlaceHolder() {
  return 10.h;
}

//
//
// ---------- Paddings & Margins EdgeInsets
//
//

EdgeInsets actionButtonPadding() {
  return EdgeInsets.symmetric(
      horizontal: isPhone()
          ? 15.w
          : isSmallPC()
              ? 100
              : 60,
      vertical: 5);
}

EdgeInsets itemMargin({bool? left, bool? right, bool? top, bool? bottom}) {
  double p = kIsWeb ? 3 : 5;
  return checkSpecificSide(p, left, right, top, bottom);
}

EdgeInsets itemMarginSmall({bool? left, bool? right, bool? top, bool? bottom}) {
  double p = kIsWeb ? 2 : 3;
  return checkSpecificSide(p, left, right, top, bottom);
}

EdgeInsets itemPaddingLarge() {
  // double h = kIsWeb ? 15 : 12.5;
  // double v = kIsWeb ? 20 : 15;
  double h = 13;
  double v = 13;
  return EdgeInsets.symmetric(horizontal: h, vertical: v);
}

EdgeInsets itemPadding({bool? left, bool? right, bool? top, bool? bottom}) {
  double p = 13;
  return checkSpecificSide(p, left, right, top, bottom);
}

EdgeInsets itemPaddingMedium({bool? left, bool? right, bool? top, bool? bottom}) {
  double p = kIsWeb ? 8 : 5;
  return checkSpecificSide(p, left, right, top, bottom);
}

EdgeInsets itemPaddingSmall({bool? left, bool? right, bool? top, bool? bottom}) {
  double p = 2;
  return checkSpecificSide(p, left, right, top, bottom);
}

EdgeInsets dialogInsetPadding() {
  return EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h);
}

EdgeInsets inputPadding() {
  return EdgeInsets.only(top: kIsWeb ? 5 : 0, left: smallWidth(), right: smallWidth());
}

EdgeInsets sheetHorizPadding() {
  return EdgeInsets.symmetric(horizontal: isPhone() ? 10 : 20);
}

EdgeInsets itemPaddingMonthly({bool? left, bool? right, bool? top, bool? bottom}) {
  return EdgeInsets.symmetric(horizontal: 0.2.w, vertical: 0.1.h);
}

EdgeInsets itemDateChipPadding() {
  double h = kIsWeb ? 0.3.w : 1.3.w;
  double v = kIsWeb ? 0.1.w : 1.w;
  return EdgeInsets.only(left: h, right: h, top: v, bottom: v);
}

EdgeInsets itemMarginMonthly({bool? left, bool? right, bool? top, bool? bottom}) {
  return EdgeInsets.symmetric(horizontal: 0.1.w, vertical: 0.1.h);
}

EdgeInsets formInputMargin() {
  return kIsWeb ? EdgeInsets.symmetric(horizontal: 8.w) : EdgeInsets.only(left: 5.w, right: 5.w);
}

EdgeInsets saveButtonPadding({bool isText = false}) {
  if (isText) {
    return EdgeInsets.symmetric(horizontal: 15, vertical: 8);
  }
  return EdgeInsets.all(8);
}

EdgeInsets checkSpecificSide(double p, bool? left, bool? right, bool? top, bool? bottom) {
  if (left != null || right != null || top != null || bottom != null) {
    return EdgeInsets.only(
      left: left == true ? p : 0,
      right: right == true ? p : 0,
      top: top == true ? p : 0,
      bottom: bottom == true ? p : 0,
    );
  } else {
    return EdgeInsets.all(p);
  }
}

//
//
// ---------- Quick SizedBoxes
//
//
Widget tinySpacerHeight() => SizedBox(height: tinyHeight());
Widget smallSpacerHeight() => SizedBox(height: smallHeight());
Widget mediumSpacerHeight() => SizedBox(height: mediumHeight());
Widget mediumSmallSpacerHeight() => SizedBox(height: mediumSmallHeight());
Widget semiLargeSpacerHeight() => SizedBox(height: semiLargeHeight());
Widget largeSpacerHeight() => SizedBox(height: largeHeight());
Widget smallPlaceHolderSpacerHeight() => SizedBox(height: smallHeightPlaceHolder());
Widget largePlaceHolderHeight() => SizedBox(height: largeHeightPlaceHolder());

Widget tinySpacerWidth() => SizedBox(width: tinyWidth());
Widget smallSpacerWidth() => SizedBox(width: smallWidth());
Widget mediumSmallSpacerWidth() => SizedBox(width: mediumSmallWidth());
Widget mediumSpacerWidth() => SizedBox(width: mediumWidth());
Widget largeSpacerWidth() => SizedBox(width: largeWidth());
