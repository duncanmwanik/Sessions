import 'package:flutter/material.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';
import 'package:sessions/_widgets/components/icons.dart';
import 'package:sessions/_widgets/components/text_styles.dart';

import '../../../_config/styling/spacing.dart';

class FilesOverview extends StatelessWidget {
  const FilesOverview({super.key, required this.fileData, this.color, this.textSize = medium});

  final Map fileData;
  final Color? color;
  final double textSize;

  @override
  Widget build(BuildContext context) {
    int fileLength = getFilesOnlyMap(fileData).length;

    return Visibility(
      visible: fileLength != 0,
      child: Padding(
        padding: itemPaddingMedium(bottom: true),
        child: Row(
          children: [
            //
            AppIcon(Icons.attach_file_rounded, size: textSize - 1, color: color),
            // tinySpacerWidth(),
            //
            AppText(size: textSize, text: fileLength.toString(), faded: true, textColor: color),
            //
          ],
        ),
      ),
    );
  }
}
