import 'package:flutter/material.dart';
import 'package:sessions/_providers/_provider_variables.dart';
import 'package:sessions/_widgets/components/buttons.dart';

import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../_config/styling/spacing.dart';
import '../../_config/styling/styler.dart';
import '../../_widgets/components/icons.dart';
import '../../_widgets/components/text_styles.dart';
import '../_tables/_helpers/checks_table.dart';
import '_helpers/add_flag.dart';
import 'dialog_flag_colors.dart';

class NewFlagInput extends StatefulWidget {
  const NewFlagInput({Key? key}) : super(key: key);

  @override
  State<NewFlagInput> createState() => _NewFlagInputState();
}

class _NewFlagInputState extends State<NewFlagInput> {
  final TextEditingController newFlagController = TextEditingController();
  FocusNode newFlagFocusNode = FocusNode();

  bool showSaveButton = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isTableAdmin(),
      child: Column(
        children: [
          //
          // Add Flag Button
          //
          if (!showSaveButton)
            Material(
              color: styler.transparent,
              child: InkWell(
                onTap: () {
                  newFlagFocusNode.requestFocus();
                  setState(() => showSaveButton = true);
                },
                borderRadius: BorderRadius.circular(borderRadiusSmall),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadiusSmall),
                  ),
                  child: Row(
                    children: [
                      AppIcon(Icons.add_rounded, faded: true),
                      mediumSpacerWidth(),
                      AppText(size: medium, text: 'Add Flag', faded: true),
                    ],
                  ),
                ),
              ),
            ),
          //
          //
          //
          if (showSaveButton)
            Column(
              children: [
                Row(
                  children: [
                    //
                    // Flag Color
                    //
                    FlagColorOptions(),
                    //
                    mediumSpacerWidth(),
                    //
                    // Text Input
                    //
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: TextFormField(
                          onFieldSubmitted: (value) {
                            if (value.trim().isNotEmpty) {
                              addFlag(value.trim(), flagInputProviderX.selectedFlagColor);
                              newFlagController.clear();
                              setState(() => showSaveButton = false);
                              hideKeyboard();
                            } else {
                              setState(() => showSaveButton = false);
                            }
                          },
                          controller: newFlagController,
                          minLines: 1,
                          maxLines: 6,
                          autofocus: true,
                          textInputAction: TextInputAction.done,
                          style: TextStyle(fontSize: textSizeMedium, fontWeight: FontWeight.w500, color: styler.textColor()),
                          decoration: InputDecoration(
                            hintText: 'Flag',
                            hintStyle: TextStyle(fontSize: textSizeMedium, fontWeight: FontWeight.w500),
                            border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(borderRadiusSmall)),
                            filled: true,
                            fillColor: styler.appColor(1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //
                smallSpacerHeight(),
                //
                //
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //
                    // Cancel Button
                    //
                    SaveButton(isCancel: true, onPressed: () => setState(() => showSaveButton = false)),
                    //
                    mediumSpacerWidth(),
                    //
                    // Save Button
                    //
                    SaveButton(
                      label: 'Add',
                      onPressed: () {
                        if (newFlagController.text.trim().isNotEmpty) {
                          addFlag(newFlagController.text.trim(), flagInputProviderX.selectedFlagColor);
                          newFlagController.clear();
                          setState(() => showSaveButton = false);
                          hideKeyboard();
                        } else {
                          setState(() => showSaveButton = false);
                        }
                      },
                    ),
                    //
                    //
                    //
                  ],
                ),
                //
                //
              ],
            ),
          //
          //
          smallSpacerHeight(),
          //
          //
        ],
      ),
    );
  }
}
