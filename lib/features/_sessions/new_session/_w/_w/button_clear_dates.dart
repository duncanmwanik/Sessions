import 'package:flutter/material.dart';

import '../../../../../_widgets/components/text_styles.dart';
import '../../../_helpers/session_helpers.dart';

class ClearAllDatesButton extends StatelessWidget {
  const ClearAllDatesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(side: BorderSide.none),
      onPressed: () {
        clearAllSelectedDates(context);
      },
      child: AppText(size: medium, text: 'Clear All'),
    );
  }
}
