import 'package:flutter/material.dart';
import 'package:sessions/_widgets/components/buttons.dart';

import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_providers/_provider_variables.dart';
import '../../_helpers/create_session.dart';
import '../../_helpers/edit_session.dart';

class SessionsAppbar extends StatelessWidget {
  const SessionsAppbar({Key? key, required this.isNewSession}) : super(key: key);

  final bool isNewSession;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        // Go Back
        //
        CustomCloseButton(isX: true),
        //
        // Save or Edit button
        //
        Flexible(
          child: SaveButton(
            label: isNewSession ? 'Create' : 'Save',
            onPressed: () {
              hideKeyboard();
              isNewSession
                  ? createNewSession(context, sessionInputProviderX.sessionInputData)
                  : editSession(context, sessionInputProviderX.sessionInputData, sessionInputProviderX.previousSessionData);
            },
          ),
        ),
      ],
    );
  }
}
