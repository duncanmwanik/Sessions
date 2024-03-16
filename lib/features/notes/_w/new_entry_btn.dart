import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_widgets/components/buttons.dart';
import 'package:sessions/_widgets/components/text_styles.dart';

import '../../../../_widgets/components/icons.dart';
import '../_helpers/tasks_helper.dart';

class NewEntryButton extends StatelessWidget {
  const NewEntryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 20),
      child: Row(
        children: [
          //
          //
          //
          AppButton(
              onPressed: () => addNewText(),
              noStyling: true,
              child: Row(
                children: [
                  AppIcon(Icons.add_rounded, tiny: true, faded: true),
                  tinySpacerWidth(),
                  // AppIcon(Icons.text_fields_rounded, tiny: true, faded: true),
                  // tinySpacerWidth(),
                  AppText(size: medium, text: 'Add Text', faded: true),
                ],
              )),
          //
          //
          //
          AppButton(
              onPressed: () => addNewSubTitle(),
              noStyling: true,
              child: Row(
                children: [
                  AppIcon(Icons.add_rounded, tiny: true, faded: true),
                  tinySpacerWidth(),
                  // AppIcon(Icons.title_rounded, tiny: true, faded: true),
                  // tinySpacerWidth(),
                  AppText(size: medium, text: 'Add Subtitle', faded: true),
                ],
              )),
          //
          //
          //
          AppButton(
              onPressed: () => addNewEntry(),
              noStyling: true,
              child: Row(
                children: [
                  AppIcon(Icons.add_rounded, tiny: true, faded: true),
                  tinySpacerWidth(),
                  // AppIcon(Icons.check_box_outline_blank_rounded, tiny: true, faded: true),
                  // tinySpacerWidth(),
                  AppText(size: medium, text: 'Add Task', faded: true),
                ],
              )),
          //
          //
          //
        ],
      ),
    );
  }
}
