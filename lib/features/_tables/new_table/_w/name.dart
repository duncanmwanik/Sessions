import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/components/text_styles.dart';

import '../../../../_config/styling/styler.dart';
import '../../../../_providers/_provider_variables.dart';
import '../../_state/table_input_provider.dart';

class TableNameFormInput extends StatelessWidget {
  const TableNameFormInput({super.key, required this.isNewTable});

  final bool isNewTable;

  @override
  Widget build(BuildContext context) {
    return Consumer<TableInputProvider>(builder: (context, input, child) {
      return Padding(
        padding: const EdgeInsets.only(left: 30),
        child: TextFormField(
          onChanged: (value) => input.addToTableInputData('t', value.trim()),
          initialValue: tableInputProviderX.tableDetailsInput['t'],
          autofocus: isNewTable,
          minLines: 1,
          maxLines: 15,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          style: TextStyle(fontSize: large, fontWeight: FontWeight.w500, color: styler.textColor()),
          decoration: InputDecoration(
            hintText: 'Table Name',
            hintStyle: TextStyle(fontSize: textSizeTitle, fontWeight: FontWeight.w500),
            border: InputBorder.none,
          ),
        ),
      );
    });
  }
}
