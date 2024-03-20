import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/spacing.dart';

import '../../../../_config/styling/styler.dart';
import '../../../../_widgets/components/icons.dart';
import '../../_state/session_input_provider.dart';

class NewSessionVenueTextForm extends StatelessWidget {
  const NewSessionVenueTextForm({super.key});

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
                  child: AppIcon(Icons.location_on, faded: true, size: 18),
                ),
                //
                smallSpacerWidth(),
                //
                //
                //
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      inputProvider.addToSessionInputData('v', value.trim());
                    },
                    initialValue: inputProvider.sessionInputData['v'],
                    minLines: 1,
                    maxLines: 10,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: textSizeNormal, color: styler.textColor()),
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      hintText: 'Venue',
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
