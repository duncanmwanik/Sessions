import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:open_filex/open_filex.dart';
import 'package:sessions/_services/hive/local_storage_service.dart';
import 'package:sessions/_widgets/components/icons.dart';
import 'package:sessions/_widgets/components/toast.dart';
import 'package:sessions/features/files/file_actions.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../_config/styling/styler.dart';
import '../../_services/cloud/firebase_storage.dart';
import '../../_widgets/components/text_styles.dart';
import '../_tables/_helpers/get_table_data.dart';

class FileItem extends StatefulWidget {
  const FileItem({super.key, required this.fileId, required this.fileName, required this.where, this.hideOptions = false});

  final String fileId;
  final String fileName;
  final String where;
  final bool hideOptions;

  @override
  State<FileItem> createState() => _FileItemState();
}

class _FileItemState extends State<FileItem> {
  bool isDownloading = false;

  @override
  Widget build(BuildContext context) {
    String fileId = widget.fileId;
    String fileName = widget.fileName;
    String where = widget.where;
    bool hideOptions = widget.hideOptions;
    String fileExtension = getfileExtension(widget.fileName);

    return ValueListenableBuilder(
        valueListenable: fileBox.listenable(),
        builder: (context, box, widget) {
          bool isFileDownloaded = fileBox.containsKey(fileId);

          // TODO: Verify path exists
          // TODO: Get web path

          return ElevatedButton(
            onPressed: isDownloading
                ? () {}
                : () async {
                    if (isFileDownloaded && !kIsWeb) {
                      //
                      //
                      try {
                        OpenFilex.open(box.get(fileId));
                      } catch (e) {
                        showToast(0, 'Failed to open file');
                      }
                      //
                      //
                    } else {
                      setState(() => isDownloading = true);

                      // wait 1 sec to show download is happening
                      await Future.delayed(Duration(seconds: 1));

                      String cloudFilePath = '${currentSelectedTable()}/$fileName';
                      String downloadPath = '${getCurrentTableName() ?? 'Others'}/$fileName';
                      cloudStorage.downloadFile(fileId, cloudFilePath, downloadPath);

                      setState(() => isDownloading = false);
                    }
                  },
            onLongPress: () {
              fileBox.clear();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: styler.itemColor(),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusMediumSmall)),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: kIsWeb ? 14 : 7),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //
                // file extention colored box
                //
                Container(
                  height: 20,
                  constraints: BoxConstraints(maxWidth: 30),
                  padding: EdgeInsets.all(3.5),
                  decoration: BoxDecoration(
                    color: styler.fileColor(fileExtension),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Center(
                      child: FittedBox(
                    child: AppText(
                      size: medium,
                      text: fileExtension.toUpperCase(),
                      textColor: styler.white,
                    ),
                  )),
                ),
                //
                smallSpacerWidth(),
                //
                Flexible(child: AppText(size: medium, text: fileName, overflow: TextOverflow.visible)),
                //
                smallSpacerWidth(),
                //
                if (!isFileDownloaded && !isDownloading) AppIcon(Icons.cloud_download_rounded, size: 16, faded: true),
                //
                if (!isFileDownloaded && !isDownloading) tinySpacerWidth(),
                //
                if (isDownloading) SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 3)),
                //
                if (!hideOptions) FileActions(where: where, fileId: fileId),
                //
                //
              ],
            ),
          );
        });
  }
}
