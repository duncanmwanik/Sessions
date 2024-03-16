import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:sessions/_providers/_provider_variables.dart';

import '../../_variables/navigation_variables.dart';

void listenToKeyboardChanges() {
  keyboardSubscription = KeyboardVisibilityController().onChange.listen((bool isKeyboardVisible) {
    globalProviderX.updateIsKeyboardOpenOpen(isKeyboardVisible);

    if (!isKeyboardVisible) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  });
}

void disposelListeningToKeyboardChanges() {
  try {
    keyboardSubscription.cancel();
  } catch (_) {}
}
