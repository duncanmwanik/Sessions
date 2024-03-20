import 'package:flutter/material.dart';
import 'package:sessions/_widgets/components/buttons.dart';
import 'package:sessions/_widgets/components/icons.dart';
import 'package:sessions/_widgets/components/text_styles.dart';

import '../../../_config/styling/styler.dart';
import '../../../_helpers/_common_helpers/global_helper.dart';
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
    return Row(
      children: [
        //
        AppIconButton(
          showSaveButton ? Icons.close_rounded : Icons.add_rounded,
          faded: true,
          size: 18,
          onPressed: () {
            if (showSaveButton) {
              setState(() => showSaveButton = false);
              newLabelController.clear();
              focusNode.unfocus();
            } else {
              setState(() => showSaveButton = true);
              focusNode.requestFocus();
            }
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
            onTap: () => setState(() => showSaveButton = true),
            controller: newLabelController,
            focusNode: focusNode,
            minLines: 1,
            maxLines: 3,
            textInputAction: TextInputAction.done,
            style: TextStyle(fontSize: medium, fontWeight: FontWeight.w400, color: styler.textColor()),
            decoration: InputDecoration(
              hintText: 'Add a label',
              hintStyle: TextStyle(fontSize: medium, fontWeight: FontWeight.w400),
              border: InputBorder.none,
            ),
          ),
        ),
        //
        //
        if (showSaveButton)
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
            child: AppIcon(Icons.done_rounded, faded: true, size: 18),
          )
        //
      ],
    );
    //
    //
    //
    //
  }
}
