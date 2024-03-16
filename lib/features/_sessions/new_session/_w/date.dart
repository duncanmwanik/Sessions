import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_widgets/components/buttons.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/components/text_styles.dart';
import '../../_state/session_input_provider.dart';
import '_w/bottom_sheet_date.dart';
import '_w/button_clear_dates.dart';
import '_w/date_item.dart';
import '_w/dialog_select_date.dart';

class NewSessionDatePicker extends StatelessWidget {
  const NewSessionDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionInputProvider>(
        builder: (context, inputProvider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                //
                //
                Row(
                  children: [
                    //
                    AppIcon(FontAwesomeIcons.calendarPlus, faded: true),
                    //
                    smallSpacerWidth(),
                    //
                    AppButton(
                        onPressed: () async {
                          hideKeyboard();
                          showSelectMultipleDatesDialogSessions(context);
                        },
                        child: Row(
                          children: [
                            AppIcon(Icons.add_rounded, size: 19),
                            tinySpacerWidth(),
                            AppText(size: medium, text: 'Add Date'),
                          ],
                        )),
                    //
                    smallSpacerWidth(),
                    //
                    AppButton(
                        onPressed: () async {
                          hideKeyboard();
                          await showDateRangeBottomSheet();
                        },
                        child: AppText(size: medium, text: 'Custom')),
                    //
                    Visibility(visible: inputProvider.sessionSelectedDates.isNotEmpty, child: ClearAllDatesButton()),
                    //
                  ],
                ),
                //
                kIsWeb ? smallSpacerHeight() : tinySpacerHeight(),
                //
                // List of Selected Dates
                //
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Wrap(
                    spacing: smallWidth(),
                    runSpacing: smallWidth(),
                    children: inputProvider.sessionSelectedDates.isNotEmpty
                        ? List.generate(inputProvider.sessionSelectedDates.length, (index) {
                            return SelectedDateChip(date: inputProvider.sessionSelectedDates[index]);
                          })
                        : [
                            Padding(
                              padding: itemPaddingMedium(left: true, top: true),
                              child: AppText(size: small, text: 'No dates selected', faded: true),
                            )
                          ],
                  ),
                ),
              ],
            ));
  }
}
