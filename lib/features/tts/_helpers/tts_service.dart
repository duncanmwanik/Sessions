import 'package:flutter_tts/flutter_tts.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';
import 'package:sessions/_providers/_provider_variables.dart';

FlutterTts flutterTts = FlutterTts();

Future<void> startTTS() async {
  try {
    String text = ttsProviderX.textToSpeak;

    if (text.trim().isNotEmpty) {
      ttsProviderX.updateIsPlaying(true);
      await flutterTts.speak(text);

      flutterTts.setCompletionHandler(() {
        ttsProviderX.updateIsPlaying(false);
      });
    }
  } catch (e) {
    errorPrint('start-tts', e);
  }
}

Future stopTTS() async {
  try {
    ttsProviderX.updateIsPlaying(false);
    await flutterTts.stop();
  } catch (e) {
    errorPrint('stop-tts', e);
  }
}

Future setSpeechRateTTS(int speechRate) async {
  try {
    await flutterTts.setSpeechRate(1.0);
  } catch (e) {
    errorPrint('stop-tts', e);
  }
}

Future setVoiceTTS(int speechRate) async {
  try {
    await flutterTts.setVoice({});
  } catch (e) {
    errorPrint('stop-tts', e);
  }
}
