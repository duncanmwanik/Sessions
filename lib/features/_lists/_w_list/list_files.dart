import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/features/files/file_list.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_helpers/_common_helpers/global_helper.dart';
import '../_state/board_input_provider.dart';

class ListFiles extends StatelessWidget {
  const ListFiles({super.key, this.listData, this.hideOptions = false});

  final Map? listData;
  final bool hideOptions;

  @override
  Widget build(BuildContext context) {
    return Consumer<ListInputProvider>(builder: (context, inputProvider, child) {
      Map files = getFilesOnlyMap(listData ?? inputProvider.listInputData);

      return Visibility(
        visible: files.isNotEmpty,
        child: Padding(
          padding: itemPadding(top: true, bottom: true),
          child: FileList(
            fileData: files,
            where: 'lists',
            hideOptions: hideOptions,
          ),
        ),
      );
    });
  }
}
