import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sessions/_widgets/components/text_styles.dart';

import '../../../../_config/styling/spacing.dart';
import '../../_helpers/get_table_data.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key, required this.label, required this.value, required this.type}) : super(key: key);

  final String label;
  final bool value;
  final String type;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: itemPaddingMedium(left: true, right: true),
      leading: AppText(size: medium, text: label),
      trailing: CupertinoSwitch(
        activeColor: Colors.blue,
        value: value,
        onChanged: (value) {
          Hive.box('${currentSelectedTable()}_notifications').put(type, value);
        },
      ),
    );
  }
}
