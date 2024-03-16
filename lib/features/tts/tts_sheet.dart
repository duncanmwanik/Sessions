import 'package:flutter/material.dart';
import 'package:sessions/features/tts/_w/text_input.dart';

import '../../_widgets/components/bottom_sheet.dart';
import '_w/appbar.dart';

Future<void> showTTSBottomSheet() async {
  await showAppBottomSheet(
    //
    // Header
    //
    header: TTSAppBar(),
    //
    //
    // Content
    //
    content: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: BouncingScrollPhysics(),
      children: [
        //
        //
        //
        TTSInput(),
        //
        //
        //
      ],
    ),
    //
    //
    whenComplete: () {},
    //
    //
  );
}
