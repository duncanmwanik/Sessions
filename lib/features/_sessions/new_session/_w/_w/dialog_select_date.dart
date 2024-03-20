import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../_config/styling/spacing.dart';
import '../../../../../_config/styling/styler.dart';
import '../../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../../_helpers/date_time/datetime_helper.dart';
import '../../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../../_widgets/dialogs/dialog_buttons.dart';
import '../../../_state/session_input_provider.dart';

Future showSelectMultipleDatesDialogSessions(BuildContext context) {
  return showAppDialog(
    //
    title: 'Select one or multiple dates',
    //
    content: Consumer<SessionInputProvider>(
      builder: (context, inputProvider, child) => SizedBox(
        height: calendarHeight(),
        width: calendarWidth(),
        child: SfDateRangePicker(
          showNavigationArrow: true,
          headerStyle: DateRangePickerHeaderStyle(textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: textSizeAppBar)),
          monthCellStyle: DateRangePickerMonthCellStyle(
            textStyle: TextStyle(fontWeight: FontWeight.w500, color: styler.textColor()),
            todayTextStyle: TextStyle(fontWeight: FontWeight.w900, color: styler.accentColor()),
            todayCellDecoration: BoxDecoration(border: Border.all(color: styler.accentColor()), shape: BoxShape.circle),
          ),
          selectionTextStyle: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
          selectionShape: DateRangePickerSelectionShape.circle,
          selectionMode: DateRangePickerSelectionMode.multiple,
          selectionColor: styler.accentColor(),
          onSelectionChanged: (DateRangePickerSelectionChangedArgs dates) {
            for (int i = 0; i < dates.value.length; i++) {
              String date = getDatePartFromDateTime(dates.value[i]);
              if (!inputProvider.sessionSelectedDates.contains(date)) {
                inputProvider.addToSessionSelectedDates(date);
              }
            }
          },
          initialSelectedDates: inputProvider.sessionSelectedDates.isNotEmpty
              ? List.generate(
                  inputProvider.sessionSelectedDates.length,
                  (index) => DateTime.parse(inputProvider.sessionSelectedDates[index]),
                )
              : null,
        ),
      ),
    ),
    //
    actions: [
      DialogActionButtonCancel(),
      DialogActionButtonAccept(onPressed: (() => popWhatsOnTop(value: true))),
    ],
    //
  );
}
