import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/styling.dart';

const double borderRadiusSuperTiny = 3.0;
const double borderRadiusTiny = 5.0;
const double borderRadiusTinySmall = 7.0;
const double borderRadiusSmall = 10.0;
const double borderRadiusMediumSmall = 15.0;
const double borderRadiusMedium = 20.0;
const double borderRadiusLarge = 30.0;

const double textSizeOnBoarding = 24.0;
const double textSizeTitle = 22.0;
const double textSizeLarge = 20.0;
const double textSizeAppBar = 18.0;
const double textSizeNormal = 16.0;
const double textSizeMedium = 14.0;
const double textSizeSmall = 12.0;
const double textSizeTiny = 10.0;

const double imageSizeTiny = 20.0;
const double imageSizeSmall = 80.0;
const double imageSizeMedium = 120.0;
const double imageSizeLarge = 250.0;

CustomAppColors styler = CustomAppColors();

List<IconData> toastIcons = [Icons.cancel_rounded, Icons.check_circle_rounded, Icons.info_rounded];

OutlineInputBorder formBorder = OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(borderRadiusTiny));
OutlineInputBorder formBorderAuth = OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(borderRadiusSmall));
