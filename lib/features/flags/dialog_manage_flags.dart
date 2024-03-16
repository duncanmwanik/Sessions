import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sessions/_providers/_provider_variables.dart';
import 'package:sessions/_widgets/others/empty_box.dart';

import '../../_config/styling/spacing.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import '../../_widgets/dialogs/action_buttons.dart';
import '../../_widgets/dialogs/app_dialog.dart';
import '../_tables/_helpers/get_table_data.dart';
import '_w/../flag.dart';
import '_w/../new_flag_input.dart';

Future showFlagsDialog(List alreadySelectedFlags) {
  flagInputProviderX.updateFlagList(alreadySelectedFlags);

  return showAppDialog(
    //
    //
    //
    title: 'Choose flag',
    //
    //
    //
    content: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: BouncingScrollPhysics(),
      children: [
        //
        //
        //
        NewFlagInput(),
        //
        //
        //
        ValueListenableBuilder(
          valueListenable: Hive.box('${currentSelectedTable()}_flags').listenable(),
          builder: (context, fbox, widget) {
            if (fbox.keys.isNotEmpty) {
              return ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: fbox.keys.length,
                  separatorBuilder: (context, index) => smallSpacerHeight(),
                  itemBuilder: (context, index) {
                    String flag = fbox.keyAt(index);
                    String color = fbox.get(flag, defaultValue: '0');
                    return FlagItem(flag: flag, color: color);
                  });
            } else {
              return EmptyBox(label: 'No flags yet', isSpaced: false);
            }
          },
        ),
        //
        //
        mediumSpacerHeight(),
        //
        //
        //
      ],
    ),
    //
    //
    //
    actions: [
      DialogActionButtonCancel(label: 'Close'),
      DialogActionButtonAccept(
        onPressed: () {
          popWhatsOnTop(value: flagInputProviderX.flagList);
        },
      ),
    ],
    //
    //
    //
  );
}
