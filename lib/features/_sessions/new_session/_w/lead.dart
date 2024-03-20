import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/spacing.dart';

import '../../../../_config/styling/styler.dart';
import '../../../../_widgets/components/icons.dart';
import '../../_state/session_input_provider.dart';

class NewSessionLeadTextForm extends StatelessWidget {
  const NewSessionLeadTextForm({super.key});

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
                  child: AppIcon(Icons.person_rounded, faded: true, size: 18),
                ),
                //
                smallSpacerWidth(),
                //
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      inputProvider.addToSessionInputData('l', value.trim());
                    },
                    initialValue: inputProvider.sessionInputData['l'],
                    minLines: 1,
                    maxLines: 10,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: textSizeNormal, color: styler.textColor()),
                    decoration: InputDecoration(
                      hintText: 'Lead',
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
