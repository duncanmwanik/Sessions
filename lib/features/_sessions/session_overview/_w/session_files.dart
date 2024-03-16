import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../files/file_list.dart';
import '../../_state/session_input_provider.dart';

class SessionFiles extends StatelessWidget {
  const SessionFiles({super.key, this.sessionData});

  final Map? sessionData;

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionInputProvider>(builder: (context, inputProvider, child) {
      Map fileMap = getFilesOnlyMap(sessionData ?? inputProvider.sessionInputData);

      return Visibility(
        visible: fileMap.isNotEmpty,
        child: Padding(
          padding: itemPadding(top: true),
          child: FileList(
            fileData: fileMap,
            where: 'sessions',
            hideOptions: true,
          ),
        ),
      );
    });
  }
}
