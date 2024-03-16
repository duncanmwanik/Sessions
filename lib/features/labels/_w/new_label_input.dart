import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_widgets/components/buttons.dart';
import 'package:sessions/_widgets/components/icons.dart';

import '../../../_config/styling/styler.dart';
import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_widgets/components/text_styles.dart';
import '../_helpers/add_label.dart';

class NewlabelInput extends StatefulWidget {
  const NewlabelInput({Key? key}) : super(key: key);

  @override
  State<NewlabelInput> createState() => _NewlabelInputState();
}

class _NewlabelInputState extends State<NewlabelInput> {
  final TextEditingController newLabelController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool showSaveButton = false;

  @override
  Widget build(BuildContext context) {
    //
    //
    //
    //
    return showSaveButton
        ? Row(
            children: [
              //
              AppIconButton(
                Icons.close_rounded,
                faded: true,
                onPressed: () {
                  setState(() => showSaveButton = false);
                  newLabelController.clear();
                  focusNode.unfocus();
                },
              ),
              //
              //
              Expanded(
                child: TextFormField(
                  onFieldSubmitted: (value) async {
                    if (value.trim().isNotEmpty) {
                      await addLabel(value.trim());
                      newLabelController.clear();
                      setState(() => showSaveButton = false);
                      hideKeyboard();
                    }
                  },
                  controller: newLabelController,
                  focusNode: focusNode,
                  minLines: 1,
                  maxLines: 6,
                  textInputAction: TextInputAction.done,
                  style: TextStyle(fontSize: medium, fontWeight: FontWeight.w500, color: styler.textColor()),
                  decoration: InputDecoration(
                    hintText: 'New Label',
                    hintStyle: TextStyle(fontSize: medium, fontWeight: FontWeight.w500),
                    border: InputBorder.none,
                  ),
                ),
              ),
              //
              //
              AppButton(
                onPressed: () async {
                  if (newLabelController.text.trim().isNotEmpty) {
                    hideKeyboard();
                    addLabel(newLabelController.text.trim());
                    newLabelController.clear();
                  }
                  focusNode.unfocus();
                  setState(() => showSaveButton = false);
                },
                noStyling: true,
                child: AppIcon(Icons.done_rounded),
              )
              //
            ],
          )
        //
        //
        //
        //
        //
        : AppButton(
            onPressed: () async {
              setState(() => showSaveButton = true);
              focusNode.requestFocus();
            },
            noStyling: true,
            child: Row(
              children: [
                //
                AppIcon(Icons.add_rounded, faded: true),
                //
                smallSpacerWidth(),
                //
                AppText(size: medium, text: 'Add Label', faded: true),
                //
              ],
            ),
          );
    //
    //
    //
    //
  }
}
