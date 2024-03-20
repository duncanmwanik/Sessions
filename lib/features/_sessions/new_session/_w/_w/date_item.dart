import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../_config/styling/styler.dart';
import '../../../../../_helpers/date_time/date_info.dart';
import '../../../../../_widgets/components/icons.dart';
import '../../../../../_widgets/components/text_styles.dart';
import '../../../_state/session_input_provider.dart';

class SelectedDateChip extends StatelessWidget {
  const SelectedDateChip({Key? key, required this.date}) : super(key: key);

  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 1, bottom: 1),
      decoration: BoxDecoration(
        color: styler.appColor(1),
        borderRadius: BorderRadius.circular(borderRadiusMedium),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(child: AppText(size: small, text: getDayInfo(date))),
          AppIconButton(
            onPressed: () {
              Provider.of<SessionInputProvider>(context, listen: false).removeFromSessionSelectedDates(date);
            },
            Icons.close,
            size: 14,
            noPadding: true,
            smallSize: true,
          )
        ],
      ),
    );
  }
}
