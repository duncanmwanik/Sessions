import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_providers/common_providers/global_provider.dart';

class KeyboardPad extends StatelessWidget {
  const KeyboardPad({super.key, required this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalProvider>(builder: (context, globalProvider, child) {
      print('open: ${globalProvider.isKeyboardOpen}');

      bool showPadding = globalProvider.isKeyboardOpen && focusNode.hasFocus;

      return Padding(
        padding: EdgeInsets.only(bottom: showPadding ? MediaQuery.of(context).viewInsets.bottom * 0.1 : 0),
        child: Container(),
      );
    });
  }
}
