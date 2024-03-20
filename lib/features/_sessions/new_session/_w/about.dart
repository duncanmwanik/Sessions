import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../../../../_widgets/components/icons.dart';
import '../../_state/session_input_provider.dart';

class NewSessionAboutTextForm extends StatelessWidget {
  const NewSessionAboutTextForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionInputProvider>(
        builder: (context, inputProvider, child) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                //
                //
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: AppIcon(Icons.subject_rounded, faded: true, size: 18),
                ),
                //
                smallSpacerWidth(),
                //
                //
                //
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      inputProvider.addToSessionInputData('a', value.trim());
                    },
                    initialValue: inputProvider.sessionInputData['a'],
                    minLines: 1,
                    maxLines: 10,
                    style: TextStyle(fontSize: textSizeNormal, color: styler.textColor()),
                    decoration: InputDecoration(
                      hintText: 'Short Description',
                      hintStyle: TextStyle(fontSize: textSizeNormal),
                      isDense: true,
                      filled: true,
                      fillColor: styler.appColor(1),
                      border: formBorder,
                    ),
                  ),
                ),
                //
                //
                //
              ],
            ));
  }
}
