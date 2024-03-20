import 'package:flutter/material.dart';
import 'package:sessions/_widgets/components/icons.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../../../../_widgets/components/text_styles.dart';
import '../../../../_widgets/others/other_widgets.dart';
import '../../_helpers/checks_table.dart';
import '../../_helpers/get_table_data.dart';
import '../../_helpers/select_table.dart';
import 'table_options.dart';

class TableTile extends StatelessWidget {
  const TableTile({Key? key, required this.tableId, this.tableGroupName = ''}) : super(key: key);

  final String tableId;
  final String tableGroupName;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getTableNameFuture(tableId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return NoWidget();
            } else if (snapshot.hasData) {
              final tableName = snapshot.data as String;

              return ElevatedButton(
                onPressed: () async => selectNewTable(tableId),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  backgroundColor: styler.appColor(2),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusTinySmall)),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //
                          // Table Name
                          //
                          Expanded(
                            child: AppText(
                              size: medium,
                              text: tableName,
                              textAlign: TextAlign.start,
                              textColor: styler.textColor(),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                          //
                          smallSpacerWidth(),
                          //
                          // Indicates if table is selected
                          //
                          if (tableId == currentSelectedTable()) AppIcon(Icons.lens, color: styler.accentColor(), size: 14),
                          //
                          //
                        ],
                      ),
                    ),
                    //
                    // Table Options
                    //
                    TableOptions(tableId: tableId, tableName: tableName, tableGroupName: tableGroupName),
                    //
                    //
                  ],
                ),
              );
            }
          }
          return NoWidget();
        });
  }
}
