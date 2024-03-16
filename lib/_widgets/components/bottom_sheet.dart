import 'dart:async';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sessions/_providers/_provider_variables.dart';
import 'package:sessions/_variables/navigation_variables.dart';

import '../../_config/styling/breakpoints.dart';
import '../../_config/styling/spacing.dart';
import '../../_config/styling/styler.dart';
import '../../_helpers/_common_helpers/global_helper.dart';

Future<void> showAppBottomSheet({
  Widget? header,
  required Widget content,
  Widget? footer,
  Color? color,
  bool isMinimized = false,
  bool noContentHorizontalPadding = false,
  FutureOr<void> Function()? whenComplete,
  FutureOr<dynamic> Function(dynamic)? then,
}) async {
  //
  //
  //
  // we record that the bottom sheet is open
  globalProviderX.updateIsBottomSheetOpen(true);
  //
  //
  // if screen is large, we show it as a dialog look-alike -> showSheetAsDialog()

  await showModalBottomSheet(
      context: homeX.currentContext!,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: isMinimized ? BoxConstraints(maxHeight: 70.h) : null,
      //
      //
      shape: isMinimized
          ? RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadiusMedium),
                topRight: Radius.circular(borderRadiusMedium),
              ),
            )
          : null,
      //
      //
      backgroundColor: showSheetAsDialog() ? styler.transparent : color,
      //
      //
      builder: (context) {
        return Column(
          children: [
            //
            // dismiss bottom sheet : IGNORE!
            // works only with (color) defined
            if (showSheetAsDialog()) GestureDetector(onTap: () => popWhatsOnTop(), child: Container(height: 50, color: styler.transparent)),
            //
            //
            // ---------- Bottom Sheet starts here !
            //
            Expanded(
              child: Card(
                elevation: isPhone() ? 0 : 0,
                color: showSheetAsDialog() ? styler.primaryColor() : color,
                margin: EdgeInsets.zero,
                shape: isMinimized
                    ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusMedium))
                    : isPhone()
                        ? null
                        : RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusMedium)),
                //
                child: Column(
                  children: [
                    //
                    // Header ----------
                    //
                    if (header != null) isPhone() ? tinySpacerHeight() : mediumSmallSpacerHeight(),
                    if (header != null)
                      Padding(
                        padding: EdgeInsets.only(left: isPhone() ? 0 : 12, right: isPhone() ? 5 : 12),
                        child: header,
                      ),
                    //
                    // Content ----------
                    //
                    Expanded(
                        child: Padding(
                      padding: noContentHorizontalPadding ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: isPhone() ? 10 : 20),
                      child: content,
                    )),
                    //
                    // Footer ----------
                    //
                    if (footer != null) Divider(height: 0),
                    if (footer != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: isPhone() ? 5 : 10, vertical: 10),
                        child: footer,
                      )
                    //
                    // ----------
                    //
                  ],
                ),
              ),
            ),
            //
            //
            // ---------- Bottom Sheet ends here !
            //
            // dismiss bottom sheet : IGNORE!
            // works only with (color) defined
            if (showSheetAsDialog()) GestureDetector(onTap: () => popWhatsOnTop(), child: Container(height: 50, color: styler.transparent)),
            //
            //
          ],
        );
      }).whenComplete(whenComplete ?? () {}).then(then ?? (_) {});
}
