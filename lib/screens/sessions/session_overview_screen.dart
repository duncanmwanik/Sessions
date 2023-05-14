import 'package:flutter/material.dart';
import '../../../widgets/back_button.dart';

// ignore: must_be_immutable
class SessionOverviewScreen extends StatelessWidget {
  SessionOverviewScreen({required this.day, super.key});

  int day;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context, Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        shrinkWrap: true,
        children: const [],
      ),
    );
  }
}
