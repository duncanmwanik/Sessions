import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../_helpers/date_time/datetime_helper.dart';
import '../../../../../_widgets/components/buttons.dart';
import '../../../../../_widgets/components/icons.dart';
import '../../../../../_widgets/components/text_styles.dart';
import '../../../_state/session_input_provider.dart';

class TimeButton extends StatelessWidget {
  const TimeButton({Key? key, required this.label, required this.time, required this.onPressed, this.isStart = false}) : super(key: key);

  final String label;
  final String time;
  final Function()? onPressed;
  final bool isStart;

  @override
  Widget build(BuildContext context) {
    String timeToShow = time != '' ? get12HourTimeFrom24HourTime(time) : '...';

    return Consumer<SessionInputProvider>(
        builder: (context, input, child) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                //
                //
                AppButton(
                    onPressed: onPressed,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(size: medium, text: label),
                        AppText(size: normal, text: timeToShow, fontWeight: FontWeight.w600),
                      ],
                    )),
                //
                //
                //
                if (timeToShow != '...' && !isStart)
                  AppIconButton(
                    onPressed: () => input.addToSessionInputData('e', ''),
                    Icons.close_rounded,
                    size: 14,
                  ),
              ],
            ));
  }
}
