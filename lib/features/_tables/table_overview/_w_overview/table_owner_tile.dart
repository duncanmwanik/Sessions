import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_config/styling/styler.dart';
import '../../../../_services/cloud/checks.dart';
import '../../../../_services/hive/local_storage_service.dart';
import '../../../../_widgets/components/text_styles.dart';
import '../../../../_widgets/components/toast.dart';

class TableOwnerTile extends StatelessWidget {
  const TableOwnerTile({super.key, required this.ownerId});

  final String ownerId;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: ownerId)).then((value) => showToast(1, 'Copied User Email to clipboard'));
      },
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      leading: AppText(size: medium, text: 'Owner'),
      trailing: userEmailsBox.get(ownerId, defaultValue: null) != null
          ? AppText(size: medium, text: userEmailsBox.get(ownerId, defaultValue: '---'))
          : FutureBuilder(
              future: getUserEmailFromCloud(ownerId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return AppText(size: medium, text: '---');
                  } else if (snapshot.hasData) {
                    String ownerEmail = snapshot.data as String;
                    userEmailsBox.put(ownerId, ownerEmail);
                    return AppText(size: medium, text: ownerEmail);
                  }
                }
                return SizedBox(
                  height: iconSize(),
                  width: iconSize(),
                  child: CircularProgressIndicator(strokeWidth: 2, color: styler.textColorFaded()),
                );
              }),
    );
  }
}
