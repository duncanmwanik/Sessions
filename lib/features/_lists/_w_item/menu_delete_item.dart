import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_widgets/components/text_styles.dart';
import 'package:sessions/_widgets/dialogs/dialog_buttons.dart';
import 'package:sessions/_widgets/menus/app_popup_menu.dart';

import '../../../../_widgets/components/icons.dart';
import '../../../_config/styling/helpers.dart';
import '../../../_config/styling/styler.dart';
import '../../../_helpers/_common_helpers/global_helper.dart';
import '../_helpers/list_item/delete_list_item.dart';

class DeleteItem extends StatefulWidget {
  const DeleteItem({Key? key, required this.bgColor, required this.listId, required this.itemId}) : super(key: key);

  final String bgColor;
  final String listId;
  final String itemId;

  @override
  State<DeleteItem> createState() => _DeleteItemState();
}

class _DeleteItemState extends State<DeleteItem> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey menuKey = GlobalKey();
    bool isColorInverted = hasBGColor(widget.bgColor);

    return AppPopupMenu(
      //
      menukey: menuKey,
      //
      menuButton: AppIconButton(
        onPressed: () => openPopupMenu(menuKey),
        Icons.delete_rounded,
        tooltip: 'Delete',
        size: 18,
        color: styler.textColorFaded(inverted: isColorInverted),
      ),
      //
      menuItems: [
        //
        //
        PopupMenuItem(
          height: 0,
          enabled: false,
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Padding(
            padding: EdgeInsets.only(left: 10, top: 5, bottom: 20),
            child: AppText(size: medium, text: 'Delete item?'),
          ),
        ),
        //
        //
        // Confirm delete
        //
        PopupMenuItem(
          height: 0,
          enabled: false,
          padding: EdgeInsets.only(left: 8, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DialogActionButtonCancel(),
              mediumSpacerWidth(),
              DialogActionButtonAccept(
                label: 'Delete',
                onPressed: () => deleteListItem(widget.listId, widget.itemId),
              )
            ],
          ),
        ),
        //
      ],
    );
  }
}
