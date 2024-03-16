import 'package:flutter/material.dart';

class TTSProvider with ChangeNotifier {
  //
  // List availableVoices = getAvailableVoices() as List;
// ----------
  bool isPlaying = false;

  void updateIsPlaying(bool value) {
    isPlaying = value;
    notifyListeners();
  }

  // ----------
  String textToSpeak = '';

  void updateTextToSpeak(String text) {
    textToSpeak = text;
    notifyListeners();
  }

  // ----------
  String selectedVoice = 'getDefaultVoice() as String';

  void updateSelectedVoice(String voice) {
    selectedVoice = voice;
    notifyListeners();
  }

  // ----------
  int speechRate = 0;

  void updateSpeechRate(int rate) {
    speechRate = rate;
    notifyListeners();
  }
}
