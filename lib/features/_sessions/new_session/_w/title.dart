import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_config/styling/styler.dart';
import '../../_state/session_input_provider.dart';

class NewSessionTitleTextForm extends StatelessWidget {
  const NewSessionTitleTextForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SessionInputProvider>(
        builder: (context, inputProvider, child) => Padding(
              padding: const EdgeInsets.only(left: 30),
              child: TextFormField(
                onChanged: (value) => inputProvider.addToSessionInputData('t', value.trim()),
                initialValue: inputProvider.sessionInputData['t'],
                minLines: 1,
                maxLines: 10,
                textInputAction: TextInputAction.next,
                style: TextStyle(fontSize: textSizeLarge, fontWeight: FontWeight.w500, color: styler.textColor()),
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(fontSize: textSizeLarge, fontWeight: FontWeight.w500),
                  border: InputBorder.none,
                ),
              ),
            ));
  }
}
