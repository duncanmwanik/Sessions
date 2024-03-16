import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_config/styling/spacing.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_helpers/user/edit_user_details.dart';
import '../../_helpers/user/user_info.dart';
import '../../_providers/common_providers/theme_provider.dart';
import '../../_widgets/components/bottom_sheet.dart';
import '../../_widgets/components/buttons.dart';
import '../../_widgets/components/text_styles.dart';
import '../../_widgets/forms/password.dart';
import '../../_widgets/forms/text.dart';
import '_w/reset_password.dart';

Future<void> showEditDetailsBottomSheet(BuildContext context) async {
  final formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController(text: getCurrentUserName());
  final TextEditingController passwordController = TextEditingController();

  await showAppBottomSheet(
    //
    // Header Actions
    //
    header: Row(
      children: [
        CustomCloseButton(),
        mediumSpacerWidth(),
        Flexible(child: AppText(size: normal, text: 'Edit Account Details')),
      ],
    ),
    //
    // Content
    //
    content: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          mediumSpacerHeight(),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormInput('Name', userNameController),
                smallSpacerHeight(),
                PasswordFormInput('Confirm Password', passwordController, true),
              ],
            ),
          ),
          mediumSpacerHeight(),
          ActionButton(
            label: 'Update',
            onPressed: () async {
              hideKeyboard();
              if (formKey.currentState!.validate()) {
                await editUserDetails(userNameController.text.trim(), passwordController.text.trim());
              }
            },
          ),
          mediumSpacerHeight(),
          Divider(),
          PasswordResetWidget(),
        ],
      );
    }),
  );
}
