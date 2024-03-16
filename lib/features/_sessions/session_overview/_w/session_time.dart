import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_providers/_provider_variables.dart';
import 'package:sessions/_widgets/components/icons.dart';

import '../../../../_helpers/date_time/date_info.dart';
import '../../../../_helpers/date_time/datetime_helper.dart';
import '../../../../_widgets/components/text_styles.dart';

class SessionTime extends StatelessWidget {
  const SessionTime({super.key, required this.startTime, required this.endTime});

  final String startTime;
  final String endTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPaddingSmall(),
      child: Wrap(
        runSpacing: tinyHeight(),
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          //
          // Date Info
          //
          AppText(size: medium, text: getDayInfoFullNames(dateTimeProviderX.selectedDate), faded: true),
          //
          //
          smallSpacerWidth(),
          //
          AppIcon(Icons.lens_rounded, size: 5),
          //
          smallSpacerWidth(),
          //
          // Time
          //
          AppText(
            size: medium,
            text: '${get12HourTimeFrom24HourTime(startTime, islonger: true)}${endTime.isNotEmpty ? ' - ${get12HourTimeFrom24HourTime(endTime, islonger: true)}' : ''} ',
            faded: true,
          ),
          //
        ],
      ),
    );
  }
}
