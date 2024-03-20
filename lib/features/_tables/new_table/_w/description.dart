import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../../../../_providers/_provider_variables.dart';
import '../../../../_widgets/components/icons.dart';
import '../../_state/table_input_provider.dart';

class TableDescriptionFormInput extends StatelessWidget {
  const TableDescriptionFormInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TableInputProvider>(builder: (context, input, child) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          //
          //
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: AppIcon(Icons.subject_rounded, faded: true, size: 18),
          ),
          //
          smallSpacerWidth(),
          //
          Expanded(
            child: TextFormField(
              onChanged: (value) => input.addToTableInputData('a', value.trim()),
              initialValue: tableInputProviderX.tableDetailsInput['a'],
              minLines: 1,
              maxLines: 15,
              style: TextStyle(fontSize: textSizeNormal, color: styler.textColor()),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: 'Add Description',
                hintStyle: TextStyle(fontSize: textSizeNormal),
                isDense: true,
                filled: true,
                fillColor: styler.appColor(1),
                border: formBorder,
              ),
            ),
          ),
          //
          //
          //
        ],
      );
    });
  }
}
