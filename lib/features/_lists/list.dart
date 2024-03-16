import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/others/scroll.dart';

import '../../_config/styling/spacing.dart';
import '../../_config/styling/styler.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_providers/common_providers/item_selection_provider.dart';
import '../../_widgets/item_actions/hover_actions.dart';
import '../_tables/_helpers/checks_table.dart';
import '_w_item/item.dart';
import '_w_item/new_item.dart';
import '_w_list/list_files.dart';
import '_w_list/list_header.dart';
import '_w_list/list_info.dart';

class BoardList extends StatefulWidget {
  const BoardList({Key? key, required this.listId, required this.listData, required this.layout}) : super(key: key);

  final String listId;
  final Map listData;
  final String layout;

  @override
  State<BoardList> createState() => _BoardListState();
}

class _BoardListState extends State<BoardList> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    Map allItemsData = widget.listData['i'] ?? {};
    String bgColor = widget.listData['c'] ?? 'x';
    bool isPinned = (widget.listData['p'] ?? '0') == '1';
    bool isArchived = (widget.listData['a'] ?? '0') == '1';
    bool isDeleted = (widget.listData['x'] ?? '0') == '1';

    return Consumer<ItemSelectionProvider>(builder: (context, selectionProvider, child) {
      bool isSelection = selectionProvider.selectedItemMap.isNotEmpty;
      bool isSelected = selectionProvider.selectedItemMap.containsKey(widget.listId);

      bool isHorizontalView = widget.layout == 'column';
      bool isGridView = widget.layout == 'grid';

      BoxDecoration boxDecoration = BoxDecoration(
        color: getItemColor(bgColor, isHovered: isHovered),
        borderRadius: BorderRadius.circular(borderRadiusMediumSmall),
        border: styler.itemBorder(isSelected, hasBgColor: hasItemColor(widget.listData['c'])),
      );

      Widget list = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          // We show onHover buttons if on web
          //
          Padding(
            padding: itemPadding(left: true, right: true, bottom: true, top: !kIsWeb),
            child: Column(
              children: [
                //
                // We show onHover buttons if on web
                //
                if (kIsWeb) tinySpacerHeight(),
                if (kIsWeb)
                  HoverActions(
                    showHoverOptions: isHovered,
                    isPinned: isPinned,
                    isArchived: isArchived,
                    isDeleted: isDeleted,
                    itemId: widget.listId,
                    itemData: widget.listData,
                    bgColor: bgColor,
                    type: 'lists',
                    showPinned: true,
                    height: 30,
                  ),
                //
                // List Title
                //
                ListHeader(listId: widget.listId, listData: widget.listData, isHorizontalView: isHorizontalView, showHoverOptions: isHovered),
                //
                //
              ],
            ),
          ),
          //
          //
          //
          Flexible(
            child: IgnorePointer(
              ignoring: isSelection,
              child: Padding(
                padding: itemPadding(left: true, right: true),
                child: ScrollConfiguration(
                  behavior: AppScrollBehavior().copyWith(scrollbars: false, overscroll: false),
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: isHorizontalView ? TopBlockedBouncingScrollPhysics() : NeverScrollableScrollPhysics(),
                    children: [
                      //
                      // list labels + reminder
                      //
                      ListInfo(listId: widget.listId, listData: widget.listData),
                      //
                      // list attachments
                      //
                      ListFiles(listData: widget.listData, hideOptions: true),
                      //
                      // list items
                      //
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: allItemsData.length,
                        itemBuilder: (ctx, index) {
                          String itemId = allItemsData.keys.toList()[index];
                          Map itemData = allItemsData[itemId];

                          return Item(itemId: itemId, itemData: itemData, listId: widget.listId, bgColor: bgColor);
                        },
                      ),
                      //
                      //
                      //
                    ],
                  ),
                ),
              ),
            ),
          ),
          //
          // New Item Input
          //
          IgnorePointer(
            ignoring: isSelection,
            child: NewItemInput(listId: widget.listId, bgColor: bgColor),
          ),
          //
          //
          //
        ],
      );

      return Padding(
        padding: isHorizontalView ? EdgeInsets.only(left: 10, right: 5, top: 7) : EdgeInsets.zero,
        child: InkWell(
          onHover: (value) => setState(() => isHovered = value),
          onTap: isTableAdmin() && isSelection
              ? () {
                  if (selectionProvider.selectedItemMap.containsKey(widget.listId)) {
                    selectionProvider.removeFromSelectedItemMap(widget.listId);
                  } else {
                    selectionProvider.addToSelectedItemMap(widget.listId, widget.listData['t'] ?? '', isPinned, 'lists');
                  }
                }
              : () {},
          onLongPress: isTableAdmin()
              ? () {
                  if (selectionProvider.selectedItemMap.containsKey(widget.listId)) {
                    selectionProvider.removeFromSelectedItemMap(widget.listId);
                  } else {
                    selectionProvider.addToSelectedItemMap(widget.listId, widget.listData['t'] ?? '', isPinned, 'lists');
                  }
                }
              : () {},
          mouseCursor: SystemMouseCursors.basic,
          focusColor: styler.transparent,
          hoverColor: styler.transparent,
          splashColor: styler.transparent,
          highlightColor: styler.transparent,
          child: isHorizontalView
              ? Container(
                  width: 300,
                  decoration: boxDecoration,
                  child: list,
                )
              : isGridView
                  ? Container(
                      constraints: BoxConstraints(maxWidth: 500),
                      decoration: boxDecoration,
                      child: list,
                    )
                  : UnconstrainedBox(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 500),
                        decoration: boxDecoration,
                        child: list,
                      ),
                    ),
        ),
      );
    });
  }
}
