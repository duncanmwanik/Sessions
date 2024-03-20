import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/breakpoints.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/features/explore/_w/explore_box.dart';
import 'package:sessions/features/pomodoro/pomodoro_sheet.dart';
import 'package:sessions/features/tts/tts_sheet.dart';

import '../../_widgets/components/toast.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({super.key});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  bool showButton = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPadding(),
      child: Align(
        alignment: isPhone() ? Alignment.topCenter : Alignment.topLeft,
        child: Wrap(
          spacing: smallWidth(),
          runSpacing: smallWidth(),
          children: [
            //
            // Text To Speech
            //
            ExploreBox(
              title: 'Text-To-Speech',
              subtitle: 'Read aloud any text.',
              icon: Icons.volume_down_rounded,
              iconColor: Colors.green,
              onPressed: () => showTTSBottomSheet(),
            ),
            //
            // Speech To Text
            //
            ExploreBox(
              title: 'Speech-To-Text',
              subtitle: 'Dictate to text form.',
              icon: Icons.keyboard_voice_rounded,
              iconColor: Colors.blueAccent,
              onPressed: () async {
                showToast(1, 'Heyyy');
              },
            ),
            //
            // Pomodoro Timer
            //
            ExploreBox(
              title: 'Pomodoro Timer',
              subtitle: 'Mindful productivity.',
              icon: Icons.timer_rounded,
              iconColor: Colors.red,
              onPressed: () => showPomodoroBottomSheet(),
            ),
            //
            //
            //
          ],
        ),
      ),
    );
  }
}
