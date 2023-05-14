import 'package:flutter/material.dart';

import '../../settings/settings_screen.dart';

AppBar homeAppbar(BuildContext context, String tableName) {
  return AppBar(
    leading: IconButton(onPressed: () {}, splashRadius: 20, icon: Icon(Icons.view_agenda)),
    title: Text(tableName),
    actions: [
      // IconButton(onPressed: () {}, splashRadius: 20, icon: Icon(Icons.more_vert_rounded)),
      // PopupMenuButton<SampleItem>(
      //     onSelected: (SampleItem item) {
      //       setState(() {
      //         selectedMenu = item;
      //       });
      //     },
      //     itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
      //       const PopupMenuItem<SampleItem>(
      //         value: SampleItem.itemOne,
      //         child: Text('Item 1'),
      //       ),
      //       const PopupMenuItem<SampleItem>(
      //         value: SampleItem.itemTwo,
      //         child: Text('Item 2'),
      //       ),
      //       const PopupMenuItem<SampleItem>(
      //         value: SampleItem.itemThree,
      //         child: Text('Item 3'),
      //       ),
      //     ],
      //   ),
      IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsScreen(),
              ),
            );
          },
          splashRadius: 20,
          icon: Icon(Icons.settings_rounded))
    ],
  );
}
