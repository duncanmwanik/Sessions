import 'package:flutter/material.dart';

import '../../_config/styling/styler.dart';
import '../../_helpers/forms/form_validation_helper.dart';

class EmailFormInput extends StatelessWidget {
  const EmailFormInput(this.hintText, this.controller, {Key? key}) : super(key: key);

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => Validator.validateEmail(email: value!),
      textInputAction: TextInputAction.next,
      style: TextStyle(fontSize: textSizeNormal, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        hintText: hintText,
        // labelText: hintText,
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
