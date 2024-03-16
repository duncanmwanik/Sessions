import 'package:flutter/material.dart';
import 'package:sessions/features/_lists/list_of_lists.dart';

import '../../_widgets/components/item_actions.dart';
import '../../_widgets/others/scroll.dart';
import '_w_list/list_actions.dart';

class BoardView extends StatelessWidget {
  const BoardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        //
        ItemActions(),
        //
        //
        ListActions(),
        //
        //
        Expanded(
          child: ScrollConfiguration(
            behavior: AppScrollBehavior().copyWith(overscroll: false),
            child: ListOfLists(),
          ),
        ),
        //
        //
      ],
    );
  }
}
