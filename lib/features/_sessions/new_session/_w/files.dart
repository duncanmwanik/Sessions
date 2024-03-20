import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_widgets/components/buttons.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/components/text_styles.dart';
import '../../../files/_helpers/upload_files.dart';
import '../../../files/file_list.dart';
import '../../_state/session_input_provider.dart';

class NewSessionFiles extends StatelessWidget {
  const NewSessionFiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionInputProvider>(builder: (context, inputProvider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              //
              //
              //
              AppIcon(Icons.attach_file_rounded, faded: true, size: 18),
              smallSpacerWidth(),
              //
              //
              //
              AppButton(
                  onPressed: () async {
                    await getFilesToUpload(where: 'sessions');
                  },
                  child: Row(
                    children: [
                      AppIcon(Icons.add_rounded, size: 16),
                      tinySpacerWidth(),
                      AppText(size: medium, text: 'Attach Files'),
                    ],
                  )),
            ],
          ),
          //
          //
          smallSpacerHeight(),
          //
          //
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: FileList(fileData: getFilesOnlyMap(inputProvider.sessionInputData), where: 'sessions'),
          ),
          //
          //
        ],
      );
    });
  }
}
