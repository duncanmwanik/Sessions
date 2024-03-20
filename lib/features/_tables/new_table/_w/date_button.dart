import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../../../../_widgets/components/buttons.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/components/text_styles.dart';
import '../../_state/table_input_provider.dart';

class DateButton extends StatelessWidget {
  const DateButton({Key? key, required this.label, required this.date, required this.onPressed}) : super(key: key);

  final String label;
  final String date;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Consumer<TableInputProvider>(
        builder: (context, input, child) => Row(
              children: [
                //
                //
                AppIcon(Icons.calendar_month_rounded, faded: true, color: label.startsWith('End') ? styler.transparent : null, size: 18),
                smallSpacerWidth(),
                //
                //
                //
                Flexible(
                  child: AppButton(
                    onPressed: onPressed,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //
                        AppText(size: medium, text: label),
                        //
                        //
                        Flexible(
                          child: AppText(
                            size: medium,
                            text: date != '' ? date : '...',
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        //
                      ],
                    ),
                  ),
                ),
                //
                //
                //
                if (date != '')
                  AppIconButton(
                    onPressed: () {
                      if (label.startsWith('S')) {
                        input.addToTableInputData('s', '');
                      } else {
                        input.addToTableInputData('e', '');
                      }
                    },
                    Icons.close_rounded,
                    tiny: true,
                    faded: true,
                  ),
                //
                //
                //
              ],
            ));
  }
}
