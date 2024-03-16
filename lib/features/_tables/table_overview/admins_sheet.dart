import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/components/bottom_sheet.dart';
import '../../../_widgets/components/buttons.dart';
import '../../../_widgets/components/text_styles.dart';
import '../../../_widgets/others/scroll.dart';
import '../_helpers/admin_helpers.dart';
import '../_helpers/checks_table.dart';
import '../_helpers/get_table_data.dart';
import '../_helpers/update_all_table_data.dart';
import '_w_admins/admin_chip.dart';
import '_w_admins/button_add_admin.dart';

Future<void> showAdminsBottomSheet({required String title}) async {
  String tableId = currentSelectedTable();

  await showAppBottomSheet(
    //
    // Header Actions
    //
    header: Row(
      children: [
        CustomCloseButton(isX: true),
        smallSpacerWidth(),
        Flexible(child: AppText(size: normal, text: title)),
      ],
    ),
    //
    // Content
    //
    content: ListView(
      shrinkWrap: true,
      physics: TopBlockedBouncingScrollPhysics(),
      children: [
        //
        //
        //
        if (isTableAdmin()) AddNewAdminButton(),
        //
        smallSpacerHeight(),
        //
        //
        //
        ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: ValueListenableBuilder(
              valueListenable: Hive.box('${tableId}_admins').listenable(),
              builder: (context, box, widget) {
                Map adminData = box.toMap();
                if (adminData.isEmpty) {
                  updateTableAdminData(tableId);
                }

                return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: adminData.length,
                    itemBuilder: (context, index) {
                      String userId = adminData.keys.toList()[index];
                      if (userEmailsBox.get(userId, defaultValue: null) == null) {
                        getAdminEmail(userId);
                      }

                      return AdminChip(
                        tableId: tableId,
                        userEmail: userEmailsBox.get(userId, defaultValue: '---'),
                        userId: userId,
                      );
                    });
              }),
        ),
      ],
    ),
  );
}
