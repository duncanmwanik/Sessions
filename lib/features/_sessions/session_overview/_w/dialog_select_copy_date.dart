import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_helpers/date_time/datetime_helper.dart';
import '../../../../_widgets/components/text_styles.dart';
import '../../../../_widgets/dialogs/app_dialog.dart';
import '../../../../_widgets/dialogs/dialog_buttons.dart';

Future showSelectCopyDatesDialog() {
  List<String> selectedDates = [];

  return showAppDialog(
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        //
        AppText(size: medium, text: 'Select one or multiple dates'),
        //
        //
        smallSpacerHeight(),
        //
        //
        Flexible(
          child: SizedBox(
            height: calendarHeight(),
            width: calendarWidth(),
            child: SfDateRangePicker(
              showNavigationArrow: true,
              headerStyle: DateRangePickerHeaderStyle(textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: textSizeMedium, color: styler.textColor())),
              monthCellStyle: DateRangePickerMonthCellStyle(
                textStyle: TextStyle(fontWeight: FontWeight.w500, color: styler.textColor()),
                todayTextStyle: TextStyle(fontWeight: FontWeight.w500, color: styler.accentColor()),
              ),
              selectionTextStyle: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              selectionMode: DateRangePickerSelectionMode.multiple,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs dates) {
                for (int d = 0; d < dates.value.length; d++) {
                  String date = getDatePartFromDateTime(dates.value[d]);
                  if (!selectedDates.contains(date)) {
                    selectedDates.add(date);
                  }
                }
              },
            ),
          ),
        ),
      ],
    ),
    actions: [
      DialogActionButtonCancel(),
      DialogActionButtonAccept(onPressed: (() => popWhatsOnTop(value: selectedDates))),
    ],
  );
}
