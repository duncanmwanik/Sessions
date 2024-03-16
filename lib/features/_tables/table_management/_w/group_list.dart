import 'package:flutter/material.dart';
import 'package:sessions/_widgets/others/other_widgets.dart';

import 'group_tile.dart';

class GroupList extends StatelessWidget {
  const GroupList({Key? key, required this.userTables, required this.groupNames}) : super(key: key);

  final Map<dynamic, dynamic> userTables;
  final List groupNames;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        itemCount: userTables.keys.toList().length,
        itemBuilder: (context, index) {
          String groupName = userTables.keys.toList()[index];

          if (!groupName.startsWith('table')) {
            return GroupTile(
              groupName: groupName,
              groupTables: userTables[groupName],
              groupNames: groupNames,
            );
          } else {
            return NoWidget();
          }
        });
  }
}
