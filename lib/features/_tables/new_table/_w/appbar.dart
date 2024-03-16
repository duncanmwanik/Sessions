import 'package:flutter/material.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';

import '../../../../_providers/_provider_variables.dart';
import '../../../../_widgets/components/buttons.dart';
import '../../_helpers/create_table.dart';
import '../../_helpers/edit_table.dart';

class TableAppBar extends StatelessWidget {
  const TableAppBar({Key? key, required this.isNewTable}) : super(key: key);

  final bool isNewTable;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        //
        CustomCloseButton(onPressed: () => popWhatsOnTop(value: true)),
        //
        // Save or Edit button
        Flexible(
          child: SaveButton(
            label: isNewTable ? 'Create' : 'Save',
            onPressed: () {
              if (isNewTable) {
                createNewTable(Map.from(tableInputProviderX.tableDetailsInput));
              } else {
                editTable(Map.from(tableInputProviderX.tableDetailsInput));
              }
            },
          ),
        ),
      ],
    );
  }
}
