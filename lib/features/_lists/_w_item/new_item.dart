import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/helpers.dart';
import 'package:sessions/_widgets/components/buttons.dart';
import 'package:sessions/_widgets/components/text_styles.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_config/styling/styler.dart';
import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_widgets/components/icons.dart';
import '../../_tables/_helpers/checks_table.dart';
import '../_helpers/list_item/create_list_item.dart';

class NewItemInput extends StatefulWidget {
  const NewItemInput({Key? key, required this.listId, required this.bgColor}) : super(key: key);

  final String listId;
  final String bgColor;

  @override
  State<NewItemInput> createState() => _NewItemInputState();
}

class _NewItemInputState extends State<NewItemInput> {
  final TextEditingController newItemController = TextEditingController();
  bool showSaveButton = false;
  FocusNode newItemFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    bool isColorInverted = hasBGColor(widget.bgColor) || isImageTheme();

    return Visibility(
      visible: isTableAdmin(),
      child: TapRegion(
        onTapOutside: (event) {
          setState(() => showSaveButton = false);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 13, vertical: 5),
          child: Column(
            children: [
              //
              // Add Button
              //
              if (!showSaveButton)
                Align(
                  alignment: Alignment.topLeft,
                  child: AppButton(
                    color: hasBGColor(widget.bgColor) ? styler.white : null,
                    noStyling: true,
                    onPressed: () {
                      newItemFocusNode.requestFocus();
                      setState(() => showSaveButton = true);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppIcon(Icons.add_rounded, size: 18, color: styler.textColorFaded(inverted: isColorInverted)),
                        tinySpacerWidth(),
                        Flexible(child: AppText(size: small, text: 'Add Item', textColor: styler.textColorFaded(inverted: isColorInverted))),
                      ],
                    ),
                  ),
                ),
              //
              showSaveButton ? smallSpacerHeight() : tinySpacerHeight(),
              //
              //
              // New Item
              //
              //
              if (showSaveButton)
                Column(
                  children: [
                    //
                    // Text Input
                    //
                    Container(
                      decoration: BoxDecoration(
                        color: styler.listItemColor(inverted: isColorInverted),
                        borderRadius: BorderRadius.circular(borderRadiusSmall),
                        boxShadow: styler.listItemShadow(inverted: isColorInverted),
                      ),
                      child: TextFormField(
                        onFieldSubmitted: (_) async {
                          if (newItemController.text.trim().isNotEmpty) {
                            createNewListItem(widget.listId, newItemController.text.trim());
                            newItemController.clear();
                          }
                          // Move to next item input
                          // The delay prevents a new line from being added
                          newItemFocusNode.requestFocus();
                          await Future.delayed(Duration(seconds: 0), () => newItemController.clear());
                          //
                        },
                        controller: newItemController,
                        focusNode: newItemFocusNode,
                        minLines: 2,
                        maxLines: 6,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(fontSize: textSizeMedium, fontWeight: FontWeight.w400, color: styler.textColor(inverted: isColorInverted)),
                        decoration: InputDecoration(
                          hintText: 'New Item',
                          hintStyle: TextStyle(fontSize: textSizeMedium, fontWeight: FontWeight.w400, color: styler.textColorFaded(inverted: isColorInverted)),
                          isDense: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                    //
                    //
                    if (kIsWeb) smallSpacerHeight(),
                    //
                    if (showSaveButton)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //
                          // Cancel Button
                          SaveButton(
                            onPressed: () async {
                              newItemController.clear();
                              newItemFocusNode.unfocus();
                              setState(() => showSaveButton = false);
                            },
                            isCancel: true,
                            label: 'Cancel',
                          ),
                          //
                          smallSpacerWidth(),
                          //
                          // Save Button
                          SaveButton(
                            onPressed: () async {
                              if (newItemController.text.trim().isNotEmpty) {
                                createNewListItem(widget.listId, newItemController.text.trim());
                                newItemController.clear();
                              }
                              setState(() => showSaveButton = false);
                              //
                              // Move to next item input
                              // The delay prevents a new line from being added
                              //
                              newItemFocusNode.requestFocus();
                              await Future.delayed(Duration(seconds: 0), () => newItemController.clear());
                            },
                            label: 'Add',
                          ),
                        ],
                      ),
                    //
                    if (kIsWeb) smallSpacerHeight(),
                    //
                    //
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
