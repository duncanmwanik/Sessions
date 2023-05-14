import 'package:flutter/material.dart';

import '../../../models/session_model.dart';
import '../../sessions/add_session_screen.dart';

class NewSessionFAB extends StatelessWidget {
  const NewSessionFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewOrEditSessionScreen(sessionData: sessionObject),
            ),
          );
        },
        child: Icon(Icons.add_rounded));
  }
}
