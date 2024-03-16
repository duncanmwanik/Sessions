import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_providers/common_providers/item_selection_provider.dart';

import '../item_actions/item_selection.dart';

class ItemActions extends StatelessWidget {
  const ItemActions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemSelectionProvider>(builder: (context, selectionProvider, child) {
      return Visibility(
        visible: selectionProvider.selectedItemMap.isNotEmpty,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SelectedItemOptions(),
        ),
      );
    });
  }
}
