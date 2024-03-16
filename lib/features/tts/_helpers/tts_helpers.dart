import 'package:sessions/features/tts/_helpers/tts_service.dart';

Future<List> getAvailableVoices() async {
  try {
    List voices = await flutterTts.getVoices;
    return voices;
  } catch (e) {
    return [];
  }
}

Future<Map> getDefaultVoice() async {
  try {
    Map voice = await flutterTts.getDefaultVoice;
    return voice;
  } catch (e) {
    return {};
  }
}
