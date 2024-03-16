import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../_providers/common_providers/theme_provider.dart';
import '../../_widgets/components/text_styles.dart';
import '../auth/_helpers/user_details_helper.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => context.go(isFirstTimeUser() ? '/welcome' : '/'), icon: Icon(Icons.arrow_back_rounded)),
        title: AppText(size: normal, text: 'Oops'),
      ),
      body: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return Center(
          child: ListView(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            children: [
              Image.asset('assets/images/oops.png', height: 35.h),
              AppText(size: normal, text: 'Oh noooo! 😅\n We really appreciate you...', textAlign: TextAlign.center),
            ],
          ),
        );
      }),
    );
  }
}
