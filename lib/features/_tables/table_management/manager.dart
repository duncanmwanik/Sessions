import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sessions/_config/styling/spacing.dart';

import '../../../_services/hive/local_storage_service.dart';
import '../../../_widgets/components/buttons.dart';
import '../_helpers/table_names.dart';
import '_w/group_list.dart';
import '_w/table_create_options.dart';
import '_w/table_list.dart';

class TableManager extends StatelessWidget {
  const TableManager({Key? key, this.isDrawer = true}) : super(key: key);

  final bool isDrawer;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: userDataBox.listenable(),
        builder: (context, box, widget) {
          Map userTableData = box.toMap();
          List groupNames = getGroupNamesAsList(userTableData);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              //
              Padding(
                padding: EdgeInsets.only(left: kIsWeb ? 12 : 0, right: 10, top: kIsWeb ? 12 : 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //
                    if (isDrawer) CustomCloseButton(),
                    //
                    CreateOptions(),
                    //
                  ],
                ),
              ),
              //
              //
              kIsWeb ? mediumSpacerHeight() : mediumSmallSpacerHeight(),
              //
              //
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(right: 10, left: 10),
                  physics: BouncingScrollPhysics(),
                  children: [
                    GroupList(userTables: userTableData, groupNames: groupNames),
                    TableList(userTableData: userTableData, groupNames: groupNames),
                    //
                    // Show a spacer if the list overflows screen
                    //
                    if (userTableData.length > 5) smallPlaceHolderSpacerHeight(),
                  ],
                ),
              ),
              //
              //
            ],
          );
        });
  }
}
