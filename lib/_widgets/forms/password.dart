import 'package:flutter/material.dart';

import '../../_config/styling/styler.dart';
import '../../_helpers/forms/form_validation_helper.dart';

class PasswordFormInput extends StatefulWidget {
  const PasswordFormInput(this.hintText, this.controller, this.isDone, {Key? key}) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final bool isDone;

  @override
  State<PasswordFormInput> createState() => _PasswordFormInputState();
}

class _PasswordFormInputState extends State<PasswordFormInput> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) => Validator.validatePassword(password: value!),
      obscureText: showPassword,
      onFieldSubmitted: null,
      textInputAction: widget.isDone ? TextInputAction.done : TextInputAction.next,
      style: TextStyle(fontSize: textSizeNormal, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
          hintText: widget.hintText,
          // labelText: widget.hintText,
          hintStyle: TextStyle(fontSize: textSizeMedium, color: styler.textColorFaded()),
          labelStyle: TextStyle(fontSize: textSizeMedium, color: styler.textColorFaded()),
          floatingLabelStyle: TextStyle(fontSize: textSizeSmall, color: styler.textColorFaded()),
          errorStyle: TextStyle(fontSize: textSizeSmall, fontWeight: FontWeight.w500, color: Colors.redAccent),
          filled: true,
          fillColor: styler.itemColor(),
          hoverColor: styler.isDarkTheme ? Colors.black12 : Colors.grey.shade200,
          border: formBorderAuth,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
                onPressed: () => setState(() => showPassword = !showPassword),
                splashRadius: 20,
                padding: EdgeInsets.zero,
                icon: Icon(showPassword ? Icons.visibility_rounded : Icons.visibility_off_rounded)),
          ),
          suffixIconColor: styler.textColorFaded()),
    );
  }
}
