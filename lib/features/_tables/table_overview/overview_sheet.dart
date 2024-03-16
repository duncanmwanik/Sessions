import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_helpers/date_time/date_info.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/components/bottom_sheet.dart';
import '../../../_widgets/components/buttons.dart';
import '../../../_widgets/components/text_styles.dart';
import '../../../_widgets/components/toast.dart';
import '../../../_widgets/others/scroll.dart';
import '../../../_widgets/others/sync_indicator.dart';
import '../_helpers/checks_table.dart';
import '../_helpers/get_table_data.dart';
import '../_helpers/table_helpers.dart';
import '_w_overview/empty_table_button.dart';
import '_w_overview/table_about.dart';
import '_w_overview/table_activity_tile.dart';
import '_w_overview/table_admin_tile.dart';
import '_w_overview/table_info_tile.dart';
import '_w_overview/table_notfications_tile.dart';
import '_w_overview/table_owner_tile.dart';

Future<void> showTableOverviewBottomSheet() async {
  String tableId = currentSelectedTable();

  await showAppBottomSheet(
    //
    // Header Actions
    //
    header: Row(
      children: [
        //
        CustomCloseButton(),
        //
        smallSpacerWidth(),
        //
        //
        //
        ValueListenableBuilder(
            valueListenable: tableNamesBox.listenable(),
            builder: (context, box, widget) {
              return Expanded(
                child: AppText(
                  size: appBar,
                  text: tableId != 'none' ? box.get(tableId, defaultValue: 'No name') : '',
                  overflow: TextOverflow.visible,
                  fontWeight: FontWeight.w700,
                ),
              );
            }),
        //
        CloudSyncIndicator(),
        //
      ],
    ),
    //
    // Content
    //
    content: ValueListenableBuilder(
        valueListenable: Hive.box('${currentSelectedTable()}_info').listenable(),
        builder: (context, box, widget) {
          Map tableInfo = box.toMap();
          String description = tableInfo['a'] ?? '';

          return tableId != 'none'
              ? ListView(
                  shrinkWrap: true,
                  physics: TopBlockedBouncingScrollPhysics(),
                  children: [
                    //
                    //
                    if (description.isNotEmpty) TableDescription(tableDescription: description),
                    if (description.isNotEmpty) Divider(height: 0),
                    //
                    //
                    TableInfoTile(leadingText: 'Starts', trailingText: getDayInfoFullNames(tableInfo['s'] ?? '-')),
                    Divider(height: 0),
                    //
                    //
                    TableInfoTile(leadingText: 'Ends', trailingText: getDayInfoFullNames(tableInfo['e'] ?? '-')),
                    Divider(height: 0),
                    //
                    //
                    TableInfoTile(
                      leadingText: 'Table ID',
                      trailingText: tableId,
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: tableId)).then((value) => showToast(1, 'Copied Table ID to clipboard.'));
                      },
                    ),
                    Divider(height: 0),
                    //
                    //
                    TableOwnerTile(ownerId: tableInfo['o'] ?? '---'),
                    Divider(height: 0),
                    //
                    //
                    TableNotificationsTile(tableName: tableInfo['t']),
                    Divider(height: 0),
                    //
                    //
                    TableActivityTile(),
                    Divider(height: 0),
                    //
                    //
                    TableAdminTile(),
                    Divider(height: 0),
                    //
                    //
                    smallSpacerHeight(),
                    smallSpacerHeight(),
                    //
                    //
                    if (isTableAdmin())
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        child: ActionButton(
                          label: 'Edit Table',
                          iconData: Icons.edit_rounded,
                          onPressed: () => prepareTableForEdit(tableInfo),
                        ),
                      ),
                    //
                    //
                    smallSpacerHeight(),
                    //
                    //
                  ],
                )
              : EmptyTable();
        }),
  );
}
