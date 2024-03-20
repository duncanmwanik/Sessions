import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/styler.dart';

import '../../../_config/styling/breakpoints.dart';
import '../../../_config/styling/spacing.dart';
import '../../../_widgets/components/bottom_sheet.dart';
import '../../../_widgets/others/scroll.dart';
import '../_helpers/table_helpers.dart';
import '_w/appbar.dart';
import '_w/date.dart';
import '_w/description.dart';
import '_w/group.dart';
import '_w/name.dart';

Future<void> showTableBottomSheet({required bool isNewTable}) async {
  await showAppBottomSheet(
    //
    // Header Actions
    //
    header: TableAppBar(isNewTable: isNewTable),
    //
    // Content
    //
    content: ListView(
      shrinkWrap: true,
      physics: TopBlockedBouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        //
        //
        Image.asset('assets/images/trw.png', height: imageSizeLarge),
        //
        //
        TableNameFormInput(isNewTable: isNewTable),
        //
        Divider(height: mediumHeight()),
        //
        //
        TableDescriptionFormInput(),
        //
        //
        isPhone() ? mediumSmallSpacerHeight() : mediumSpacerHeight(),
        //
        //
        NewTableDate(),
        //
        isPhone() ? mediumSmallSpacerHeight() : mediumSpacerHeight(),
        //
        if (isNewTable) TableGroupSelector(),
      ],
    ),
    //
    //
    //
    then: (clearTable) => clearTableInput(clearTable),
  );
}
