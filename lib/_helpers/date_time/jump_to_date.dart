import '../../_providers/_provider_variables.dart';
import '../../_widgets/dialogs/dialog_select_date.dart';
import 'datetime_helper.dart';

Future<void> jumpToDate(DateTime? date) async {
  if (date != null) {
    switch (viewsProviderX.selectedSessionView) {
      case 0:
        dateTimeProviderX.updateSelectedDate(getDatePartFromDateTime(date));
        break;
      case 1:
        dateTimeProviderX.updateCurrentWeekDates(date);
        break;
      case 2:
        dateTimeProviderX.updateSelectedYear(date.year);
        dateTimeProviderX.changeSelectedMonth(date.month);
        await dateTimeProviderX.updateMonthDatesMap();
        break;
      default:
    }
  }
}

Future<void> jumpToDateDialog() async {
  await showSelectSingleDateDialog(actionLabel: 'Jump').then((date) async {
    jumpToDate(date);
  });
}
