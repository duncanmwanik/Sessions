import 'package:flutter/material.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';
import 'package:sessions/_providers/_provider_variables.dart';
import 'package:sessions/_widgets/components/buttons.dart';
import 'package:sessions/features/labels/label_manager.dart';

import '../../../_config/styling/breakpoints.dart';
import '../../../_widgets/components/bottom_sheet.dart';

Future<List?> showLabelsBottomSheet({bool isSelection = false, List alreadySelected = const []}) async {
  labelsProviderX.updateLabelList(alreadySelected);

  await showAppBottomSheet(
    //
    isMinimized: !showSheetAsDialog(),
    //
    // Header Actions
    //
    header: Row(
      mainAxisAlignment: isSelection ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
      children: [
        //
        //
        CustomCloseButton(isX: true),
        //
        //
        if (isSelection) SaveButton(label: isSelection ? 'Save' : 'Done', onPressed: () => popWhatsOnTop())
        //
        //
      ],
    ),
    //
    //
    // Content
    //
    content: LabelManager(isSelection: isSelection, isPopable: true),
    //
    //
  );

  return labelsProviderX.selectedLabelList;
}
