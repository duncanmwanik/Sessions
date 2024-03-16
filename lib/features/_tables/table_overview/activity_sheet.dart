import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sessions/_widgets/others/empty_box.dart';
import 'package:sessions/_widgets/others/scroll.dart';
import 'package:styled_text/styled_text.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_config/styling/styler.dart';
import '../../../_helpers/activity/activity_helper.dart';
import '../../../_widgets/components/bottom_sheet.dart';
import '../../../_widgets/components/buttons.dart';
import '../../../_widgets/components/text_styles.dart';
import '../_helpers/get_table_data.dart';
import '_w_activity/dialog_table_activity.dart';

Future<void> showActivityBottomSheet() async {
  await showAppBottomSheet(
    //
    // Header Actions
    //
    header: Row(
      children: [
        CustomCloseButton(isX: true),
        smallSpacerWidth(),
        Flexible(child: AppText(size: normal, text: 'Activity History')),
      ],
    ),
    //
    // Content
    //
    content: ValueListenableBuilder(
        valueListenable: Hive.box('${currentSelectedTable()}_activity').listenable(),
        builder: (context, box, widget) {
          return box.keys.toList().isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: TopBlockedBouncingScrollPhysics(),
                  itemCount: box.keys.toList().length,
                  separatorBuilder: (context, index) => Divider(height: 0),
                  itemBuilder: (BuildContext context, int index) {
                    int reversedIndex = box.keys.toList().length - (index + 1);
                    String timestamp = box.keys.toList()[reversedIndex];
                    String activityText = box.get(timestamp) ?? 'Recent changes were made';
                    String date = getActivityDateTime(timestamp);
                    return ListTile(
                      dense: true,
                      onLongPress: () async {
                        await showTableActivityDialog(context, box, timestamp);
                      },
                      title: StyledText(
                        text: activityText,
                        style: TextStyle(color: styler.textColor(), fontWeight: FontWeight.normal, fontSize: textSizeMedium),
                        tags: {
                          'b': StyledTextTag(style: TextStyle(fontWeight: FontWeight.bold, color: styler.textColor(), fontSize: textSizeMedium)),
                        },
                      ),
                      subtitle: AppText(size: small, text: date, fontWeight: FontWeight.w400, faded: true),
                    );
                  })
              : EmptyBox(label: 'No new activity');
        }),
  );
}
