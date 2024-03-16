import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/features/tts/_state/tts_provider.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_widgets/components/buttons.dart';
import '../../../_widgets/components/icons.dart';
import '../../../_widgets/components/text_styles.dart';
import '../../../_widgets/menus/app_popup_menu.dart';
import '../../../_widgets/menus/menu_item.dart';

class TTSControls extends StatelessWidget {
  const TTSControls({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey voiceMenuKey = GlobalKey();
    // final GlobalKey rateMenuKey = GlobalKey();

    return Consumer<TTSProvider>(builder: (context, ttsProvider, child) {
      String selectedVoice = ttsProvider.selectedVoice;

      return Row(
        children: [
          //
          // Voice Persona
          //
          AppPopupMenu(
            //
            menukey: voiceMenuKey,
            //
            // Shows selected view on the Header
            // Opens menu when pressed
            //
            menuButton: AppButton(
              onPressed: () => openPopupMenu(voiceMenuKey),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  // Selected Voice
                  //
                  Flexible(child: AppText(size: medium, text: 'Karen')),
                  //
                  smallSpacerWidth(),
                  //
                  AppIcon(Icons.arrow_drop_down, tiny: true),
                  //
                ],
              ),
            ),
            menuItems: List.generate(
              4,
              (index) => popupMenuItem(
                label: 'Karen',
                trailing: ttsProvider.selectedVoice == selectedVoice ? Icons.done_rounded : null,
                onTap: () async {
                  ttsProvider.updateSelectedVoice('voice');
                  //pops menu
                  popWhatsOnTop();
                },
              ),
            ),
          )
          //
          //
          //
        ],
      );
    });
  }
}
