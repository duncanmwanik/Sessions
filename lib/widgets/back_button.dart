// custom back button
import 'package:flutter/material.dart';

Widget customBackButton(BuildContext context, Color color) {
  return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Icon(
        Icons.arrow_back_ios,
        color: color,
      ));
}
