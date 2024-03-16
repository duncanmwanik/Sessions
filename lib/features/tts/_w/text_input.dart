import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_variables/text_descriptions.dart';
import 'package:sessions/features/tts/_state/tts_provider.dart';

import '../../../_config/styling/styler.dart';

class TTSInput extends StatelessWidget {
  const TTSInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TTSProvider>(builder: (context, ttsProvider, child) {
      // for (var element in ttsProvider.availableVoices) {
      //   print(element);
      // }
      return TextFormField(
        onChanged: (value) => ttsProvider.updateTextToSpeak(value.trim()),
        initialValue: ttsProvider.textToSpeak,
        focusNode: noteTextFocusNode,
        autofocus: true,
        minLines: 1,
        maxLines: null,
        style: TextStyle(fontSize: textSizeNormal, fontWeight: FontWeight.w400, color: styler.textColor()),
        decoration: InputDecoration(
          hintText: 'Type or paste text from clipboard...',
          hintStyle: TextStyle(fontSize: textSizeNormal, fontWeight: FontWeight.w400),
          border: InputBorder.none,
        ),
      );
    });
  }
}
