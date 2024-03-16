import 'package:flutter/material.dart';
import 'package:sessions/_widgets/others/other_widgets.dart';

import '../../_helpers/_common_helpers/global_helper.dart';
import '../components/text_styles.dart';
import 'action_buttons.dart';
import 'app_dialog.dart';

Future<dynamic> showConfirmationDialog({required String title, String content = '', String? yeslabel, String? noLabel, bool showBottomPadding = false}) {
  return showAppDialog(
    title: title,
    content: content.isNotEmpty ? AppText(size: medium, text: content, faded: true, overflow: TextOverflow.visible) : NoWidget(),
    actions: [
      DialogActionButtonCancel(label: noLabel),
      DialogActionButtonAccept(label: yeslabel, onPressed: (() => popWhatsOnTop(value: true))),
    ],
    showBottomPadding: showBottomPadding,
  );
}
