import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/spacing.dart';

import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_helpers/date_time/datetime_helper.dart';
import '../../../../_widgets/components/icons.dart';
import '../../_state/session_input_provider.dart';
import '_w/button_time.dart';

class NewSessionTimePicker extends StatelessWidget {
  const NewSessionTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionInputProvider>(builder: (context, input, child) {
      return Row(
        children: [
          //
          //
          //
          AppIcon(FontAwesomeIcons.solidClock, faded: true, size: 18),
          //
          smallSpacerWidth(),
          //
          //
          //
          Flexible(
            child: Wrap(
              spacing: smallWidth(),
              children: [
                //
                //
                //
                TimeButton(
                    label: 'Starts at ',
                    time: input.sessionInputData['s'] ?? '',
                    isStart: true,
                    onPressed: () async {
                      hideKeyboard();
                      String time = input.sessionInputData['s'] != null && input.sessionInputData['s'] != '' ? input.sessionInputData['s'] : '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}';
                      TimeOfDay? startDayTime = await showTimePicker(context: context, cancelText: 'Cancel', confirmText: 'Done', initialTime: TimeOfDay(hour: getHour(time), minute: getMinute(time)));

                      if (startDayTime != null) {
                        input.addToSessionInputData('s', '${startDayTime.hour}:${startDayTime.minute}');
                      }
                    }),
                //
                //
                //
                TimeButton(
                    label: 'Ends at ',
                    time: input.sessionInputData['e'] ?? '',
                    onPressed: () async {
                      hideKeyboard();
                      String time = input.sessionInputData['e'] != null && input.sessionInputData['e'] != '' ? input.sessionInputData['e'] : '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}';
                      TimeOfDay? endDayTime = await showTimePicker(context: context, cancelText: 'Cancel', confirmText: 'Done', initialTime: TimeOfDay(hour: getHour(time), minute: getMinute(time)));

                      if (endDayTime != null) {
                        input.addToSessionInputData('e', '${endDayTime.hour}:${endDayTime.minute}');
                      }
                    }),
                //
                //
              ],
            ),
          ),
        ],
      );
    });
  }
}
