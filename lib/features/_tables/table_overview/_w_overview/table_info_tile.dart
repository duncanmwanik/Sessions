import 'package:flutter/material.dart';

import '../../../../_widgets/components/text_styles.dart';

class TableInfoTile extends StatelessWidget {
  const TableInfoTile({super.key, required this.leadingText, required this.trailingText, this.onTap});

  final String leadingText;
  final String trailingText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      onTap: onTap ?? () {},
      leading: AppText(size: medium, text: leadingText),
      trailing: AppText(size: medium, text: trailingText.isNotEmpty ? trailingText : '---', textAlign: TextAlign.end),
    );
  }
}
