import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/features/tts/_helpers/tts_service.dart';

import '../../../_widgets/components/icons.dart';
import '../_state/tts_provider.dart';

class TTSButton extends StatelessWidget {
  const TTSButton({Key? key, this.text}) : super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Consumer<TTSProvider>(builder: (context, ttsProvider, child) {
      return AppIconButton(
        onPressed: () {
          if (text != null) {
            ttsProvider.updateTextToSpeak(text ?? '');
          }
          ttsProvider.isPlaying ? stopTTS() : startTTS();
        },
        ttsProvider.isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded,
        faded: true,
      );
    });
  }
}
