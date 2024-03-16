import 'package:flutter/material.dart';
import 'package:sessions/_widgets/components/text_styles.dart';

import '../../../../_config/styling/spacing.dart';

class TableDescription extends StatelessWidget {
  const TableDescription({super.key, required this.tableDescription});

  final String tableDescription;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPadding(),
      child: AppText(
        size: medium,
        text: tableDescription,
        faded: true,
        // textAlign: TextAlign.cs,
        overflow: TextOverflow.visible,
      ),
    );
  }
}
