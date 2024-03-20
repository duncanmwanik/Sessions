import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/components/text_styles.dart';
import '../../../../_widgets/others/other_widgets.dart';
import 'group_options.dart';
import 'table_tile.dart';

class GroupTile extends StatelessWidget {
  const GroupTile({Key? key, required this.groupName, required this.groupTables, required this.groupNames}) : super(key: key);

  final String groupName;

  final Map groupTables;
  final List groupNames;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: styler.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusSmall),
        side: styler.lightTableBorder(),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(bottom: 5),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        childrenPadding: itemPaddingMedium(left: true, right: true, top: true, bottom: true),
        shape: Border(),
        iconColor: styler.textColorFaded(),
        trailing: GroupOptions(groupName: groupName),
        title: Row(
          children: [
            AppIcon(FontAwesomeIcons.solidFolder, color: styler.textColorFaded(), size: 18),
            mediumSpacerWidth(),
            Flexible(child: AppText(size: medium, text: groupName)),
          ],
        ),
        children: [
          ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: BouncingScrollPhysics(),
              itemCount: groupTables.keys.toList().length,
              separatorBuilder: (context, index) => SizedBox(height: 3),
              itemBuilder: (context, index) {
                if (groupTables.keys.toList()[index].startsWith('table')) {
                  return TableTile(tableId: groupTables.keys.toList()[index], tableGroupName: groupName);
                } else {
                  return NoWidget();
                }
              }),
        ],
      ),
    );
  }
}
