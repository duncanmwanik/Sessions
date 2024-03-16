import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_config/styling/breakpoints.dart';
import '../../../../_config/styling/spacing.dart';
import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_helpers/date_time/date_info.dart';
import '../../../../_helpers/date_time/datetime_helper.dart';
import '../../../../_widgets/dialogs/dialog_select_date.dart';
import '../../_state/table_input_provider.dart';
import 'date_button.dart';

class NewTableDate extends StatelessWidget {
  const NewTableDate({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TableInputProvider>(
        builder: (context, input, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                // Start Date
                //
                DateButton(
                    label: 'Starts on ',
                    date: getDayInfoFullNames(input.tableDetailsInput['s'] ?? ''),
                    onPressed: () async {
                      hideKeyboard();
                      await showSelectSingleDateDialog(initialDate: input.tableDetailsInput['s'] != '' ? input.tableDetailsInput['s'] : null).then((date) async {
                        if (date != null) {
                          input.addToTableInputData('s', getDatePartFromDateTime(date));
                        }
                      });
                    }),
                //
                isPhone() ? smallSpacerHeight() : mediumSpacerHeight(),
                //
                // End Date
                //
                DateButton(
                    label: 'Ends on ',
                    date: getDayInfoFullNames(input.tableDetailsInput['e'] ?? ''),
                    onPressed: () async {
                      hideKeyboard();
                      await showSelectSingleDateDialog(initialDate: input.tableDetailsInput['e'] != '' ? input.tableDetailsInput['e'] : null).then((date) async {
                        if (date != null) {
                          input.addToTableInputData('e', getDatePartFromDateTime(date));
                        }
                      });
                    }),
                //
              ],
            ));
  }
}
