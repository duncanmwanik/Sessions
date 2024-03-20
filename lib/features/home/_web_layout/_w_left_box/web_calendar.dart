import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/components/text_styles.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../_config/styling/styler.dart';
import '../../../../_helpers/date_time/jump_to_date.dart';
import '../../../../_providers/common_providers/datetime_provider.dart';

class WebCalendar extends StatelessWidget {
  const WebCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DateTimeProvider>(builder: (context, dateProvider, child) {
      return Center(
        child: SizedBox(
          height: 220,
          child: SfDateRangePicker(
            showNavigationArrow: true,
            headerStyle: DateRangePickerHeaderStyle(textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: medium, color: styler.textColorFaded())),
            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: TextStyle(fontWeight: FontWeight.w100, color: styler.textColorFaded(), fontSize: tiny),
              todayTextStyle: TextStyle(fontWeight: FontWeight.w500, color: styler.textColorFaded(), fontSize: tiny),
              todayCellDecoration: BoxDecoration(border: Border.all(color: styler.accentColor()), shape: BoxShape.circle),
            ),
            selectionTextStyle: TextStyle(fontWeight: FontWeight.w500, color: styler.white, fontSize: tiny),
            selectionColor: styler.accentColor(),
            selectionShape: DateRangePickerSelectionShape.circle,
            selectionMode: DateRangePickerSelectionMode.single,
            initialSelectedDate: DateTime.parse(dateProvider.selectedDate),
            onSelectionChanged: (DateRangePickerSelectionChangedArgs dates) => jumpToDate(dates.value),
          ),
        ),
      );
    });
  }
}
