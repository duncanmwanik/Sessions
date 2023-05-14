import 'package:flutter/material.dart';

import '../../../config/theme/theme_constants.dart';

// ignore: must_be_immutable
class AuthFormField extends StatefulWidget {
  AuthFormField({super.key, required this.controller, required this.validator, required this.data});

  TextEditingController controller;
  String? validator;
  String? data;

  @override
  State<AuthFormField> createState() => _AuthFormFieldState();
}

class _AuthFormFieldState extends State<AuthFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: boxDecoration,
      child: TextFormField(
        textInputAction: TextInputAction.next,
        style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(hintText: "Email Address", hintStyle: hintStyle, border: InputBorder.none),
        controller: widget.controller,
        validator: (value) => widget.validator,
        onSaved: (String? val) {
          setState(() {
            widget.data = val;
          });
        },
      ),
    );
  }
}
