import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_widgets/components/checkbox.dart';
import 'package:sessions/_widgets/components/text_styles.dart';

import '../../_config/styling/styler.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_providers/_provider_variables.dart';
import '../../features/_tables/_helpers/table_helpers.dart';
import '../../features/_tables/_state/table_input_provider.dart';
import '../components/icons.dart';
import 'app_dialog.dart';
import 'dialog_buttons.dart';

Future showSelectTableGroupsDialog() {
  List<String> groupNames = getGroupNames();

  return showAppDialog(
    title: 'Select Groups',
    content: ListView.separated(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: groupNames.length,
        separatorBuilder: (context, index) => smallSpacerHeight(),
        itemBuilder: (context, index) {
          String group = groupNames[index];

          return Consumer<TableInputProvider>(
              builder: (context, inputProvider, child) => ListTile(
                    onTap: () => inputProvider.updateSelectedTableGroups(group),
                    tileColor: styler.appColor(1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadiusSmall),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppIcon(FontAwesomeIcons.solidFolder, color: styler.textColorFaded(), size: 16),
                        mediumSpacerWidth(),
                        Flexible(child: AppText(size: medium, text: group)),
                      ],
                    ),
                    trailing: CheckBoxOverview(
                      isChecked: inputProvider.selectedTableGroups.contains(group),
                      onTap: () => inputProvider.updateSelectedTableGroups(group),
                      isTiny: true,
                    ),
                  ));
        }),
    actions: [
      DialogActionButtonCancel(),
      DialogActionButtonAccept(
        label: 'Done',
        onPressed: () => popWhatsOnTop(value: tableInputProviderX.selectedTableGroups),
      ),
    ],
  );
}
