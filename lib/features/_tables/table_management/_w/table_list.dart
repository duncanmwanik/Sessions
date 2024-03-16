import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sessions/_widgets/others/other_widgets.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../../../../_providers/_provider_variables.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/components/text_styles.dart';
import 'info_empty_data.dart';
import 'table_tile.dart';

class TableList extends StatelessWidget {
  const TableList({Key? key, required this.userTableData, required this.groupNames}) : super(key: key);

  final Map<dynamic, dynamic> userTableData;
  final List groupNames;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusSmall),
        side: styler.lightTableBorder(),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: ExpansionTile(
        onExpansionChanged: (value) => globalProviderX.changeKeepTableListTileOpen('TableList', value),
        initiallyExpanded: globalProviderX.keepTableListTileOpen,
        tilePadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        childrenPadding: itemPaddingMedium(left: true, right: true, bottom: true),
        shape: Border(),
        iconColor: styler.textColorFaded(),
        collapsedIconColor: styler.textColorFaded(),
        title: Row(
          children: [
            AppIcon(FontAwesomeIcons.solidFolder, color: styler.textColorFaded(), size: 18),
            mediumSpacerWidth(),
            Flexible(child: AppText(size: medium, text: 'All Tables')),
          ],
        ),
        children: [
          if (userTableData.isNotEmpty)
            ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                itemCount: userTableData.keys.toList().length,
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemBuilder: (context, index) {
                  String tableId = userTableData.keys.toList()[index];
                  if (tableId.startsWith('table')) {
                    return TableTile(tableId: tableId);
                  } else {
                    return NoWidget();
                  }
                }),
          if (userTableData.isEmpty) EmptyTableData(),
        ],
      ),
    );
  }
}
