import 'package:flutter/material.dart';

Widget divider() {
  return const Divider(
    height: 0,
  );
}

Widget titleText(String text) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: const TextStyle(fontWeight: FontWeight.w600),
  );
}

Widget leadingText(String text) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: const TextStyle(fontWeight: FontWeight.w500),
  );
}
