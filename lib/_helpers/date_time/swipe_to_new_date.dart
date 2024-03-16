import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../_providers/common_providers/datetime_provider.dart';
import '../../_variables/navigation_variables.dart';
import 'datetime_helper.dart';

Future<void> swipeToNewDate(BuildContext context) async {
  try {
    String currentDate = Provider.of<DateTimeProvider>(context, listen: false).selectedDate;
    String newDate = currentDate;

    if (dayViewPageController.position.userScrollDirection == ScrollDirection.reverse) {
      newDate = getDatePartFromDateTime(DateTime.parse(currentDate).add(Duration(days: 1)));
    } else {
      newDate = getDatePartFromDateTime(DateTime.parse(currentDate).subtract(Duration(days: 1)));
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DateTimeProvider>(context, listen: false).updateSelectedDate(newDate);
    });
  } catch (e) {
    //
  }
}
