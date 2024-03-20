import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../_config/styling/styler.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import 'app_dialog.dart';
import 'dialog_buttons.dart';

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
          todayCellDecoration: BoxDecoration(border: Border.all(color: styler.accentColor()), shape: BoxShape.circle),
        ),
        selectionTextStyle: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
        selectionShape: DateRangePickerSelectionShape.circle,
        selectionMode: DateRangePickerSelectionMode.single,
        selectionColor: styler.accentColor(),
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
