import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_providers/_provider_variables.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../_config/styling/spacing.dart';
import '../../../../../_config/styling/styler.dart';
import '../../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../../_helpers/date_time/datetime_helper.dart';
import '../../../../../_widgets/dialogs/action_buttons.dart';
import '../../../../../_widgets/dialogs/app_dialog.dart';
import '../../../_state/session_input_provider.dart';

Future showSelectDateRangeDialog(BuildContext context, String type) {
  String initialDate = type.startsWith('start') ? sessionInputProviderX.dateRangeStart : sessionInputProviderX.dateRangeEnd;

  return showAppDialog(
    //
    title: type.startsWith('start') ? 'Select start date' : 'Select end date',
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
          ),
          selectionTextStyle: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
          selectionShape: DateRangePickerSelectionShape.circle,
          selectionMode: DateRangePickerSelectionMode.single,
          initialSelectedDate: initialDate.isNotEmpty ? DateTime.parse(initialDate) : null,
          onSelectionChanged: (DateRangePickerSelectionChangedArgs dates) {
            if (dates.value != null) {
              if (type == 'start') {
                Provider.of<SessionInputProvider>(context, listen: false).updateDateRangeStart(getDatePartFromDateTime(dates.value));
              } else {
                Provider.of<SessionInputProvider>(context, listen: false).updateDateRangeEnd(getDatePartFromDateTime(dates.value));
              }
            }
          },
        ),
      ),
    ),
    //
    actions: [
      DialogActionButtonCancel(),
      DialogActionButtonAccept(label: 'Done', onPressed: (() => popWhatsOnTop())),
    ],
    //
  );
}
