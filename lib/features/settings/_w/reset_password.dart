import 'package:flutter/material.dart';
import 'package:sessions/_widgets/components/text_styles.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_config/styling/styler.dart';
import '../../../_helpers/user/user_info.dart';
import '../../../_widgets/components/buttons.dart';
import '../../auth/_helpers/reset_password.dart';

class PasswordResetWidget extends StatelessWidget {
  const PasswordResetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusSmall),
        side: BorderSide(color: styler.borderColor()),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        textColor: styler.textColor(),
        iconColor: styler.textColorFaded(),
        title: AppText(size: normal, text: 'Reset Password'),
        children: [
          smallSpacerHeight(),
          //
          AppText(size: medium, text: 'A password reset link will be sent to your email.', faded: true),
          //
          mediumSpacerHeight(),
          //
          ActionButton(
            onPressed: () async {
              await resetPassword(email: getCurrentUserEmail());
            },
            label: 'Reset',
            color: Colors.red.shade600,
          ),
          //
          mediumSpacerHeight(),
          //
        ],
      ),
    );
  }
}
