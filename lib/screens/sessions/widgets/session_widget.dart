import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/theme/theme_constants.dart';
import '../../../helpers/datetime_helper.dart';
import '../../../providers/darkmode_provider.dart';

class SessionWidget extends StatelessWidget {
  const SessionWidget({super.key, required this.session});

  final Map<String, String> session;

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkThemeProvider>(builder: (context, appTheme, child) {
      return Container(
        padding: const EdgeInsets.only(right: 5, top: 5, bottom: 5),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: appTheme.isDarkTheme ? darkColor : lightColor,
            boxShadow: const [BoxShadow(blurRadius: 1.0, offset: Offset(0, 0))]),
        child: Row(
          children: [
            Container(
              width: 5,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.red,
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  session['name'] ?? "A Session",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        '${get12HourTimeFrom24HourTime(session['time'] ?? "0:0")} |',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      session['lead'] ?? "No lead",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                splashColor: Colors.red,
                hoverColor: Colors.red,
                focusColor: Colors.red,
                onTap: () {
                  print(DateTime.now());
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
