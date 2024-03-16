import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/breakpoints.dart';

import '../../_config/styling/spacing.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_providers/common_providers/layout_provider.dart';
import '../../_widgets/components/text_styles.dart';
import '../../_widgets/others/empty_box.dart';
import '../_tables/_helpers/get_table_data.dart';
import '../labels/_state/labels_provider.dart';
import '_w_list/snap_scroll_physics.dart';
import 'list.dart';

class ListOfLists extends StatelessWidget {
  const ListOfLists({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LabelsProvider>(
        builder: (context, labelsProvider, child) => ValueListenableBuilder(
            valueListenable: Hive.box('${currentSelectedTable()}_lists').listenable(),
            builder: (context, box, widget) {
              List allListIds = box.keys.toList();
              List pinnedLists = [];
              List unpinnedLists = [];
              String currentLabel = labelsProvider.selectedLabel;

              for (var id in allListIds) {
                Map listData = box.get(id);
                List labelList = listData['l'] != null ? getSplitList(listData['l'].toString()) : [];
                bool isDeleted = listData['x'] != null ? listData['x'].toString() == '1' : false;
                bool isArchived = listData['a'] != null ? listData['a'].toString() == '1' : false;
                bool isPinned = listData['p'] != null ? listData['p'].toString() == '1' : false;

                if (isDeleted) {
                  if (currentLabel == 'Trash') {
                    if (isPinned) {
                      pinnedLists.add(id);
                    } else {
                      unpinnedLists.add(id);
                    }
                  }
                } else if (isArchived) {
                  if (currentLabel == 'Archive' && !isDeleted) {
                    if (isPinned) {
                      pinnedLists.add(id);
                    } else {
                      unpinnedLists.add(id);
                    }
                  }
                } else {
                  if ((currentLabel == 'All' || labelList.contains(currentLabel)) && !isDeleted && !isArchived) {
                    if (isPinned) {
                      pinnedLists.add(id);
                    } else {
                      unpinnedLists.add(id);
                    }
                  }
                }
              }

              return (pinnedLists.isEmpty && unpinnedLists.isEmpty)
                  ? EmptyBox(label: 'No lists')
                  : Consumer<LayoutProvider>(builder: (context, layoutProvider, child) {
                      String layout = layoutProvider.layoutBoard;
                      bool isGridLayout = layoutProvider.layoutBoard == 'grid';

                      //
                      // Horizontal List View
                      //
                      if (layout == 'column') {
                        List horizonList = [];
                        horizonList.addAll(pinnedLists);
                        horizonList.addAll(unpinnedLists);

                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: kIsWeb ? null : SnapScrollPhysics(snapSize: 300),
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(horizonList.length, (index) {
                              String listId = horizonList[index];
                              Map listData = box.get(listId);

                              return BoardList(listId: listId, listData: listData, layout: layout);
                            }),
                          ),
                        );
                      }
                      //
                      // Grid View: crossAxisCount = 2 or 3 depending of screen width
                      // Column View: crossAxisCount = 1
                      //
                      else {
                        return Align(
                          alignment: Alignment.topCenter,
                          child: ListView(
                            shrinkWrap: true,
                            padding: itemPadding(left: true, right: true),
                            physics: BouncingScrollPhysics(),
                            children: [
                              //
                              // Pinned Lists
                              //
                              if (pinnedLists.isNotEmpty) PinnedInfoText(text: 'Pinned'),
                              //
                              //
                              MasonryGridView.count(
                                key: UniqueKey(),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: isGridLayout ? gridCount() : 1,
                                crossAxisSpacing: isPhone() ? smallWidth() : mediumWidth(),
                                mainAxisSpacing: isPhone() ? smallWidth() : mediumWidth(),
                                itemCount: pinnedLists.length,
                                itemBuilder: (context, index) {
                                  String listId = pinnedLists[index];
                                  Map listData = box.get(listId);

                                  return BoardList(listId: listId, listData: listData, layout: layout);
                                },
                              ),
                              //
                              // Unpinned Lists
                              //
                              if (pinnedLists.isNotEmpty && unpinnedLists.isNotEmpty) PinnedInfoText(text: 'Others'),
                              if (pinnedLists.isEmpty) smallSpacerHeight(),
                              //
                              //
                              MasonryGridView.count(
                                key: UniqueKey(),
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                crossAxisCount: isGridLayout ? gridCount() : 1,
                                crossAxisSpacing: isPhone() ? smallWidth() : mediumWidth(),
                                mainAxisSpacing: isPhone() ? smallWidth() : mediumWidth(),
                                itemCount: unpinnedLists.length,
                                itemBuilder: (context, index) {
                                  String listId = unpinnedLists[index];
                                  Map listData = box.get(listId);

                                  return BoardList(listId: listId, listData: listData, layout: layout);
                                },
                              ),
                              //
                              //
                              largePlaceHolderHeight(),
                              largePlaceHolderHeight(),
                              //
                              //
                            ],
                          ),
                        );
                      }
                    });
            }));
  }
}
