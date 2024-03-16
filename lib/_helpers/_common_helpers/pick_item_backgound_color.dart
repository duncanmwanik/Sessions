import 'package:flutter/cupertino.dart';

import '../../_widgets/dialogs/dialog_item_bg_color.dart';
import '../edits/edit_item_extras.dart';
import 'global_helper.dart';

Future<void> pickItemBackgroundColor(BuildContext context, {required String where, required String action, required String itemId}) async {
  try {
    popWhatsOnTop();

    await showPickItemBgColor().then((color) async {
      if (color != null) {
        editItemExtras(where: where, action: action, itemId: itemId, type: 'c', value: color);
      }
    });
  } catch (e) {
    errorPrint('delete-item-forever-$where', e);
  }
}
