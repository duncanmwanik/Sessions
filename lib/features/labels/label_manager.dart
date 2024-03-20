import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_providers/common_providers/item_selection_provider.dart';
import 'package:sessions/_providers/common_providers/views_provider.dart';
import 'package:sessions/_widgets/others/scroll.dart';
import 'package:sessions/features/labels/_w/label_item.dart';

import '../../_config/styling/spacing.dart';
import '../../_widgets/components/text_styles.dart';
import '../_tables/_helpers/checks_table.dart';
import '../_tables/_helpers/get_table_data.dart';
import '_state/labels_provider.dart';
import '_w/default_label_item.dart';
import '_w/new_label_input.dart';

class LabelManager extends StatelessWidget {
  const LabelManager({Key? key, this.isPopable = false, this.isSelection = false}) : super(key: key);

  final bool isPopable;
  final bool isSelection;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('${currentSelectedTable()}_labels').listenable(),
        builder: (context, box, widget) {
          return Consumer3<LabelsProvider, ViewsProvider, ItemSelectionProvider>(builder: (context, labelsProvider, viewsProvider, selectionProvider, child) {
            String selected = labelsProvider.selectedLabel;

            return selectionProvider.selectedItemMap.isEmpty
                ? ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: TopBlockedBouncingScrollPhysics(),
                    children: [
                      //
                      //
                      //
                      if (isTableAdmin()) NewlabelInput(),
                      //
                      //
                      //
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        children: [
                          //
                          //
                          //
                          if (!isSelection) DefaultLabelItem(label: 'All', iconData: Icons.label_rounded, isSelected: selected == 'All', isPopable: isPopable),
                          if (!isSelection) tinySpacerHeight(),
                          if (!isSelection) DefaultLabelItem(label: 'Archive', iconData: Icons.archive_rounded, isSelected: selected == 'Archive', isPopable: isPopable),
                          if (!isSelection) tinySpacerHeight(),
                          if (!isSelection) DefaultLabelItem(label: 'Trash', iconData: Icons.delete_rounded, isSelected: selected == 'Trash', isPopable: isPopable),
                          if (!isSelection) tinySpacerHeight(),
                          //
                          // User created labels
                          //
                          ListView.separated(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: box.keys.length,
                              separatorBuilder: (context, index) => tinySpacerHeight(),
                              itemBuilder: (context, index) {
                                String label = box.keyAt(index);

                                return LabelItem(label: label, isSelection: isSelection, isPopable: isPopable);
                              }),
                          //
                          //
                        ],
                      ),
                    ],
                  )
                : Padding(
                    padding: itemPadding(top: true),
                    child: Center(
                        child: AppText(
                      size: medium,
                      text: 'You have selected items',
                      fontWeight: FontWeight.w400,
                      faded: true,
                    )),
                  );
          });
        });
  }
}
