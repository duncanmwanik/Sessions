import 'package:flutter/material.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_config/styling/styler.dart';
import '../../../_providers/_provider_variables.dart';
import '../../_tables/_helpers/checks_table.dart';

class ItemTextInput extends StatelessWidget {
  const ItemTextInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        listItemInputProviderX.addToListItemData('t', value.trim());
      },
      onTapOutside: (_) => removeFocus(),
      enabled: isTableAdmin(),
      initialValue: listItemInputProviderX.listItemData['t'] ?? '---',
      minLines: 4,
      maxLines: null,
      textInputAction: TextInputAction.done,
      style: TextStyle(fontSize: textSizeMedium, fontWeight: FontWeight.w500, color: styler.textColor()),
      decoration: InputDecoration(
        hintText: 'Item text cannot be empty',
        hintStyle: TextStyle(fontSize: textSizeMedium, fontWeight: FontWeight.w500, color: styler.textColorFaded()),
        isDense: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadiusSmall), borderSide: BorderSide.none),
        contentPadding: itemPadding(),
        filled: true,
        fillColor: styler.appColor(1),
      ),
    );
  }
}
