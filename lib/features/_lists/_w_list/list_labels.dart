import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../labels/label_list.dart';
import '../_state/board_input_provider.dart';

class ListLabels extends StatelessWidget {
  const ListLabels({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ListInputProvider>(builder: (context, inputProvider, child) {
      return LabelList(
        where: 'lists',
        labelString: inputProvider.listInputData['l'],
      );
    });
  }
}
