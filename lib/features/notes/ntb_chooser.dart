import 'package:flutter/material.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_widgets/components/item_actions.dart';
import 'task_view.dart';

class NTViewChooser extends StatefulWidget {
  const NTViewChooser({super.key});

  @override
  State<NTViewChooser> createState() => _NTViewChooserState();
}

class _NTViewChooserState extends State<NTViewChooser> {
  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPadding(left: true, right: true),
      child: Column(
        children: [
          //
          //
          //
          ItemActions(),
          //
          //
          //
          Expanded(child: TaskView()),
          //
          //
          //
        ],
      ),
    );
  }
}
