import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../_config/styling/spacing.dart';
import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_widgets/components/text_styles.dart';

class EmptyTable extends StatelessWidget {
  const EmptyTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: itemPadding(bottom: true),
            child: Image.asset('assets/images/table.png', height: smallImageHeight()),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: itemPadding(),
                side: kIsWeb ? BorderSide.none : null,
              ),
              onPressed: kIsWeb
                  ? null
                  : () {
                      popCurrentScreen();
                      openDrawer();
                    },
              child: AppText(size: medium, text: kIsWeb ? 'Select a table first' : 'Tap to select a table')),
        ],
      ),
    );
  }
}
