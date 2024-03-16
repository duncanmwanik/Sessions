import 'package:flutter/material.dart';

import '../_common_helpers/global_helper.dart';

Future<void> deleteActivityForUser(BuildContext context, var box, String activityId) async {
  try {
    box.delete(activityId);
    popWhatsOnTop();
  } catch (e) {
    errorPrint('delete-activity-for-user', e);
  }
}
