import 'package:flutter/material.dart';

Future<bool?> showConfirmDeletionDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        title: const Text(
          'Are you sure you want to delete?',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
            ),
            onPressed: (() => Navigator.pop(context, false)),
            child: Text(
              "No",
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
            ),
            onPressed: (() => Navigator.pop(context, true)),
            child: Text(
              "Yes",
            ),
          ),
        ],
      );
    },
  );
}
