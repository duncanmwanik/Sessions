import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/features/files/file_list.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_helpers/_common_helpers/global_helper.dart';
import '../_state/list_item_input_provider.dart';

class ListItemFiles extends StatelessWidget {
  const ListItemFiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ListItemInputProvider>(builder: (context, inputProvider, child) {
      return Padding(
        padding: itemPadding(top: true),
        child: FileList(fileData: getFilesOnlyMap(inputProvider.listItemData), where: 'listItems'),
      );
    });
  }
}
