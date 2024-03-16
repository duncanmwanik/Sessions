import 'package:flutter/material.dart';

import '../../_config/styling/styler.dart';
import '../../_helpers/forms/form_validation_helper.dart';

class TextFormInput extends StatelessWidget {
  const TextFormInput(this.hintText, this.controller, {Key? key}) : super(key: key);

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => Validator.validateName(name: value!),
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      style: TextStyle(fontSize: textSizeNormal, fontWeight: FontWeight.w500, color: styler.textColor()),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
        hintStyle: TextStyle(fontSize: textSizeMedium, color: styler.textColorFaded()),
        labelStyle: TextStyle(fontSize: textSizeMedium, color: styler.textColorFaded()),
        floatingLabelStyle: TextStyle(fontSize: textSizeSmall, color: styler.textColorFaded()),
        errorStyle: TextStyle(fontSize: textSizeSmall, fontWeight: FontWeight.w500, color: Colors.redAccent),
        filled: true,
        fillColor: styler.itemColor(),
        hoverColor: styler.isDarkTheme ? Colors.black12 : Colors.grey.shade200,
        border: formBorderAuth,
      ),
    );
  }
}
