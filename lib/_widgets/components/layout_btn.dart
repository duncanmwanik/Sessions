import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_widgets/components/buttons.dart';

import '../../_providers/common_providers/layout_provider.dart';
import '../../_providers/common_providers/views_provider.dart';
import '../../_variables/common_variables.dart';
import '../../_widgets/components/icons.dart';

class LayoutButton extends StatelessWidget {
  const LayoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ViewsProvider, LayoutProvider>(builder: (context, viewsProvider, layoutProvider, child) {
      int view = viewsProvider.selectedHomeView;

      bool isBoardView = view == listsViewNo;
      bool isNoteView = view == notesViewNo;

      bool showLayoutButton = isNoteView || isBoardView;

      String layout = '';

      if (isBoardView) {
        layout = layoutProvider.layoutBoard;
      }
      if (isNoteView) {
        layout = layoutProvider.layoutNotes;
      }

      return Visibility(
        visible: showLayoutButton,
        child: Padding(
          padding: EdgeInsets.only(right: tinyWidth()),
          child: AppButton(
            onPressed: () {
              String value = 'grid';

              if (isNoteView) {
                if (layout == 'grid') {
                  value = 'row';
                }
                layoutProvider.updateLayout('notes', value);
              }
              //
              //
              //
              if (isBoardView) {
                if (layout == 'grid') {
                  value = 'row';
                }
                if (layout == 'row') {
                  value = 'column';
                }
                layoutProvider.updateLayout('lists', value);
              }
              //
            },
            isRound: true,
            noStyling: true,
            child: AppIcon((isNoteView ? iconLayoutNotes[layout] : iconLayoutBoard[layout]) ?? Icons.lens, faded: true, tiny: true),
          ),
        ),
      );
    });
  }
}
