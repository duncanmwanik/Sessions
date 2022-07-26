import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sessions/views/auth/welcome_page.dart';
import 'package:sessions/views/home/home_page.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:sessions/darkmode/dark_theme_styles.dart';
import 'globals.dart';
import 'providers/darkmode_providers.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Dark theme stuff
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();
  themeChangeProvider.darkTheme = await themeChangeProvider.darkThemePreference.getTheme();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _userId = prefs.getString('userId');

  if(_userId!=null){

    String tableId = prefs.getString('tableId') ?? 'table_mo_gmail_com';
    String selectedDate =  prefs.getString('selectedDate') ?? DateTime.now().toString().split(' ')[0];

    await FirebaseDatabase.instance.reference().child('updates').once().then((DataSnapshot snapshot) {
      if(snapshot.value['version']!=version){
        update = true;
      }
    }).onError((error, stackTrace){
      print('----ERROR checking update!');
    });

    await FirebaseDatabase.instance.reference().child('tables/$tableId').once().then((DataSnapshot snapshot) {
      if(snapshot.value!=null){
        bool tableExists = true;
        List admins = snapshot.value['admins'].toString().split(',');
        bool isAdmin = admins.contains(_userId);
        bool isSuperAdmin = snapshot.value['superadmin'].toString()==_userId ? true : false;
        bool isChecker = snapshot.value['checker'].toString()==_userId ? true : false;

        runApp(ChangeNotifierProvider(
          create: (_) {
            return themeChangeProvider;
          },
          child: Consumer<DarkThemeProvider>(
            builder: (BuildContext context, value, Widget child) {
              return new MaterialApp(
                title: 'Sessions',
                debugShowCheckedModeBanner: false,
                theme: Styles.themeData(themeChangeProvider.darkTheme, context),
                home: HomePage(tableId, _userId, selectedDate, tableExists, isAdmin, isSuperAdmin, isChecker),
              );
            },
          ),
        ));
      }
      else{
        runApp(ChangeNotifierProvider(
          create: (_) {
            return themeChangeProvider;
          },
          child: Consumer<DarkThemeProvider>(
            builder: (BuildContext context, value, Widget child) {
              return new MaterialApp(
                title: 'Sessions',
                debugShowCheckedModeBanner: false,
                theme: Styles.themeData(themeChangeProvider.darkTheme, context),
                home: HomePage(tableId, _userId, selectedDate, false, false, false, false),
              );
            },
          ),
        ));
      }
    }).onError((error, stackTrace){
      print('----ERROR checking table details!');
    });
  }
  else{
    runApp(ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget child) {
          return new MaterialApp(
            title: 'Sessions',
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: WelcomePage(),
          );
        },
      ),
    ));
  }
}
