import 'package:flutter/material.dart';
import 'package:sessions/variables/provider_variables.dart';
import '../../config/theme/theme_constants.dart';
import '../../helpers/form_validation/form_validation_helper.dart';
import '../../variables/global_variables.dart';
import '../../variables/session_variables.dart';

// ignore: must_be_immutable
class NewOrEditSessionScreen extends StatefulWidget {
  NewOrEditSessionScreen({required this.sessionData, super.key});

  Map sessionData;

  @override
  State<NewOrEditSessionScreen> createState() => _NewOrEditSessionScreenState();
}

class _NewOrEditSessionScreenState extends State<NewOrEditSessionScreen> {
  DateTime selectedtime = DateTime.now();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController leadController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();

  String? sessionName, sessionLead, sessionAbout;
  String sessionType = 'Session';
  int colorCode = 0;

  @override
  initState() {
    super.initState();
  }

  Widget sessionTypeItem({required int index, required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Chip(
        // backgroundColor: sessionType == sessionTypeList[index] ? lightColor : darkColor,
        label: Text(sessionTypeList[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Create new session',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.only(top: h * 0.0, bottom: h * 0.05),
                child: Image.asset(
                  'assets/images/datepicker.png',
                  height: h * 0.2,
                  width: h * 0.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                margin: EdgeInsets.only(bottom: 10),
                decoration: boxDecoration,
                child: TextFormField(
                  validator: (value) => Validator.validateName(name: value!),
                  onSaved: (String? val) {
                    sessionName = val;
                  },
                  controller: nameController,
                  minLines: 1,
                  maxLines: 3,
                  maxLength: 60,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: themeWatch.isDarkTheme ? darkColor : lightColor,
                  ),
                  decoration: InputDecoration(hintText: 'Title of the session', hintStyle: hintStyleSession, border: InputBorder.none),
                  cursorColor: themeWatch.isDarkTheme ? darkColor : lightColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                margin: EdgeInsets.only(bottom: 10),
                decoration: boxDecoration,
                child: TextFormField(
                  validator: (value) => Validator.validateName(name: value!),
                  onSaved: (String? val) {
                    sessionLead = val;
                  },
                  controller: leadController,
                  minLines: 1,
                  maxLines: 3,
                  maxLength: 60,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: themeWatch.isDarkTheme ? darkColor : lightColor,
                  ),
                  decoration: InputDecoration(hintText: 'Who leads the session', hintStyle: hintStyleSession, border: InputBorder.none),
                  cursorColor: themeWatch.isDarkTheme ? darkColor : lightColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                margin: EdgeInsets.only(bottom: 10),
                decoration: boxDecoration,
                child: TextFormField(
                  minLines: 5,
                  maxLines: 5,
                  maxLength: 100,
                  textCapitalization: TextCapitalization.words,
                  validator: (value) => Validator.validateName(name: value!),
                  onSaved: (String? val) {
                    sessionAbout = val;
                  },
                  controller: aboutController,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: themeWatch.isDarkTheme ? darkColor : lightColor,
                  ),
                  decoration: InputDecoration(hintText: 'Brief description', hintStyle: hintStyleSession, border: InputBorder.none),
                  cursorColor: themeWatch.isDarkTheme ? darkColor : lightColor,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                margin: EdgeInsets.only(bottom: 10),
                decoration: boxDecoration,
                child: Wrap(
                  // direction: Axis.vertical,
                  alignment: WrapAlignment.spaceAround,
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: sessionTypeList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return sessionTypeItem(
                              index: index,
                              onTap: () {
                                setState(() {
                                  sessionType = sessionTypeList[index];
                                });
                              });
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Visibility(
          visible: false,
          child: FloatingActionButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)), onPressed: () {}, child: Icon(Icons.done_rounded)),
        ),
      ),
    );
  }
}
