import 'package:flutter/material.dart';

import '../../../variables/global_variables.dart';

Widget signInUpButton({required BuildContext context, required String label, required Function() onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(minimumSize: Size(w * 0.48, 50), padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
    onPressed: onPressed,
    child: Text(
      label,
    ),
  );
}
