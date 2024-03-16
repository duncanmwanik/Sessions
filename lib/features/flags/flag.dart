import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_providers/_provider_variables.dart';
import 'package:sessions/_widgets/components/checkbox.dart';

import '../../_config/styling/spacing.dart';
import '../../_config/styling/styler.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_variables/common_variables.dart';
import '../../_widgets/components/buttons.dart';
import '../../_widgets/components/icons.dart';
import '../../_widgets/components/text_styles.dart';
import '_helpers/delete_flag.dart';
import '_helpers/edit_flag.dart';
import '_state/flag_input_provider.dart';

class FlagItem extends StatefulWidget {
  const FlagItem({Key? key, required this.flag, required this.color}) : super(key: key);

  final String flag;
  final String color;

  @override
  State<FlagItem> createState() => _FlagItemState();
}

class _FlagItemState extends State<FlagItem> {
  final TextEditingController editFlagController = TextEditingController();
  bool isEditMode = false;
  bool showColorPicker = false;
  String newColor = '0';
  String previousText = '';

  @override
  void initState() {
    setState(() {
      editFlagController.text = widget.flag;
      newColor = widget.color;
      previousText = widget.flag;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        // Flag
        //
        Row(
          children: [
            //
            // Change Color
            //
            if (isEditMode)
              AppIconButton(
                onPressed: () {
                  hideKeyboard();
                  setState(() {
                    showColorPicker = !showColorPicker;
                  });
                },
                Icons.palette_rounded,
                noPadding: true,
              )
            //
            // Selected Flag checkbox
            //
            else
              Consumer<FlagInputProvider>(builder: (context, flagProvider, child) {
                return CheckBoxOverview(
                  isChecked: flagProvider.flagList.contains(widget.flag),
                  onTap: () {
                    if (flagProvider.flagList.contains(widget.flag)) {
                      flagProvider.removeFromFlagList(widget.flag);
                    } else {
                      flagProvider.addToFlagList(widget.flag);
                    }
                  },
                );
              }),
            // /
            //
            smallSpacerWidth(),
            //
            // Flag Text Input
            //
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.only(left: 15),
                  backgroundColor: flagColors[newColor]!.color,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusSmall)),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () async {
                  if (Provider.of<FlagInputProvider>(context, listen: false).flagList.contains(widget.flag)) {
                    Provider.of<FlagInputProvider>(context, listen: false).removeFromFlagList(widget.flag);
                  } else {
                    Provider.of<FlagInputProvider>(context, listen: false).addToFlagList(widget.flag);
                  }
                },
                child: Row(
                  children: [
                    //
                    // Flag Text
                    //
                    Expanded(
                      child: TextFormField(
                        onFieldSubmitted: (_) {
                          if (editFlagController.text.trim().isNotEmpty && (editFlagController.text.trim() != widget.flag || newColor != widget.color)) {
                            hideKeyboard();
                            editFlag(editFlagController.text.trim(), newColor, widget.flag);
                            setState(() {
                              isEditMode = false;
                              showColorPicker = false;
                              previousText = editFlagController.text.trim();
                            });
                          } else {
                            setState(() {
                              isEditMode = false;
                              showColorPicker = false;
                              editFlagController.text = previousText;
                            });
                          }
                        },
                        textAlignVertical: TextAlignVertical.top,
                        readOnly: !isEditMode,
                        enabled: isEditMode,
                        controller: editFlagController,
                        minLines: 1,
                        maxLines: null,
                        textInputAction: TextInputAction.done,
                        style: TextStyle(fontSize: textSizeMedium, fontWeight: FontWeight.w500, color: flagColors[newColor]!.textColor),
                        decoration: InputDecoration(
                          hintText: 'Flag',
                          hintStyle: TextStyle(fontSize: textSizeMedium, fontWeight: FontWeight.w500),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    //
                    // Edit Flag Icon Button
                    //
                    if (!isEditMode)
                      AppIconButton(
                        onPressed: () {
                          setState(() {
                            isEditMode = true;
                          });
                          flagInputProviderX.updateSelectedFlagColor(newColor);
                        },
                        Icons.edit,
                        color: styler.black,
                        size: 16,
                      ),
                    //
                    // Delete Flag Icon Button
                    //
                    if (isEditMode)
                      AppIconButton(
                        Icons.delete,
                        tiny: true,
                        onPressed: () {
                          hideKeyboard();
                          setState(() {
                            isEditMode = false;
                            showColorPicker = false;
                          });
                          deleteFlag(widget.flag);
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        //
        //
        // Save + Cancel Buttons
        //
        //
        if (isEditMode)
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //
              // Cancel Button
              //
              SaveButton(
                isCancel: true,
                onPressed: () {
                  setState(() {
                    isEditMode = false;
                    showColorPicker = false;
                    editFlagController.text = previousText;
                  });
                },
              ),
              //
              mediumSpacerWidth(),
              //
              // Save Button
              //
              SaveButton(
                onPressed: () {
                  if (editFlagController.text.trim().isNotEmpty && (editFlagController.text.trim() != widget.flag || newColor != widget.color)) {
                    hideKeyboard();
                    editFlag(editFlagController.text.trim(), newColor, widget.flag);
                    setState(() {
                      isEditMode = false;
                      showColorPicker = false;
                      previousText = editFlagController.text.trim();
                    });
                  } else {
                    setState(() {
                      isEditMode = false;
                      showColorPicker = false;
                      editFlagController.text = previousText;
                    });
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
        //
        //
        // Flag Color Picker
        //
        Visibility(
          visible: showColorPicker,
          child: Container(
            padding: itemPadding(),
            margin: itemMargin(bottom: true, top: true),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(borderRadiusSmall + 8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                //
                //
                Padding(
                  padding: itemPadding(bottom: true),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      //
                      AppText(size: normal, text: 'Choose a color'),
                      //
                      //
                      AppIconButton(Icons.close, onPressed: () => setState(() => showColorPicker = false)),
                      //
                      //
                    ],
                  ),
                ),
                //
                //
                //
                smallSpacerHeight(),
                //
                //
                //
                GridView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: tinyWidth(),
                    crossAxisSpacing: tinyWidth(),
                  ),
                  children: List.generate(
                      flagColors.length,
                      (indexColor) => ElevatedButton(
                            onPressed: () {
                              setState(() {
                                newColor = indexColor.toString();
                                showColorPicker = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: flagColors[indexColor.toString()]!.color,
                              fixedSize: Size(10, 30),
                              shape: CircleBorder(),
                            ),
                            child: AppIcon(
                              Icons.lens,
                              size: 15,
                              color: flagColors[indexColor.toString()]!.textColor,
                            ),
                          )),
                ),
                //
                //
                //
              ],
            ),
          ),
        ),
        //
        //
        //
      ],
    );
  }
}
