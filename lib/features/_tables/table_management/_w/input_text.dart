import 'package:flutter/material.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';

class TextInput extends StatelessWidget {
  const TextInput(
    this.hintText,
    this.controller,
    this.textType, {
    Key? key,
    this.autoFocus = false,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final TextInputType textType;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: itemPadding(left: true, right: true),
      decoration: BoxDecoration(
        color: styler.primaryColor(),
        borderRadius: BorderRadius.circular(borderRadiusSmall),
        border: Border.all(width: 1.5, color: styler.borderColor()),
      ),
      child: TextFormField(
        controller: controller,
        autofocus: autoFocus,
        keyboardType: textType,
        textInputAction: TextInputAction.done,
        minLines: 2,
        maxLines: 5,
        style: TextStyle(fontSize: textSizeNormal, fontWeight: FontWeight.w500, color: styler.textColor()),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: textSizeNormal, fontWeight: FontWeight.w500),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
