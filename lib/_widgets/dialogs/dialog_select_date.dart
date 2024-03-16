import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../_config/styling/styler.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import 'action_buttons.dart';
import 'app_dialog.dart';

Future showSelectSingleDateDialog({String actionLabel = 'Done', String? initialDate}) {
  DateTime? date;

  return showAppDialog(
    content: SizedBox(
      height: calendarHeight(),
      width: calendarWidth(),
      child: SfDateRangePicker(
        showNavigationArrow: true,
        headerStyle: DateRangePickerHeaderStyle(textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: textSizeAppBar)),
        monthCellStyle: DateRangePickerMonthCellStyle(
          textStyle: TextStyle(fontWeight: FontWeight.w500, color: styler.textColor()),
          todayTextStyle: TextStyle(fontWeight: FontWeight.w900, color: styler.accentColor()),
        ),
        selectionTextStyle: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
        selectionShape: DateRangePickerSelectionShape.circle,
        selectionMode: DateRangePickerSelectionMode.single,
        initialSelectedDate: (initialDate != null && initialDate.isNotEmpty) ? DateTime.parse(initialDate) : null,
        onSelectionChanged: (DateRangePickerSelectionChangedArgs dates) {
          date = dates.value;
        },
      ),
    ),
    actions: [
      DialogActionButtonCancel(),
      DialogActionButtonAccept(label: actionLabel, onPressed: (() => popWhatsOnTop(value: date))),
    ],
  );
}
