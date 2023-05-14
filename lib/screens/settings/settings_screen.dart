import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/widgets/darkmode_switch.dart';

import '../../helpers/url_launcher_helper.dart';
import '../../providers/global_provider.dart';
import '../../variables/provider_variables.dart';
import 'widgets/list_tile_widgets.dart.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  initState() {
    globalWatch.getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Consumer<GlobalProvider>(builder: (context, g, child) {
        return ListView(
          shrinkWrap: true,
          children: [
            ListTile(leading: titleText("ACCOUNT")),
            divider(),
            ListTile(
              leading: leadingText('Username'),
              trailing: leadingText(g.userName.replaceAll("|", " ")),
              onTap: () {},
            ),
            divider(),
            ListTile(
              leading: leadingText('Email'),
              trailing: leadingText(g.userEmail),
              onTap: () {},
            ),
            divider(),
            ListTile(leading: titleText("DISPLAY")),
            divider(),
            ListTile(
              leading: leadingText('Dark Mode'),
              trailing: darkModeSwitch(),
            ),
            divider(),
            ListTile(leading: titleText("SUPPORT")),
            divider(),
            ListTile(
              leading: leadingText('Send Feedback'),
              onTap: () async {
                sendUserFeedbackViaEmail();
              },
            ),
            divider(),
            ListTile(
              leading: leadingText('App Version'),
              trailing: leadingText('Alpha 1.0'),
              onTap: () {},
            ),
            divider(),
          ],
        );
      }),
    );
  }
}
