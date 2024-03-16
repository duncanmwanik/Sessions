import 'package:flutter/material.dart';
import 'package:sessions/features/files/file.dart';

import '../../../_config/styling/spacing.dart';

class FileList extends StatelessWidget {
  const FileList({super.key, required this.fileData, required this.where, this.hideOptions = false});

  final Map fileData;
  final String where;
  final bool hideOptions;

  @override
  Widget build(BuildContext context) {
    List noteFilesIds = fileData.keys.toList();

    return Wrap(
      spacing: tinyWidth(),
      runSpacing: tinyHeight(),
      children: List.generate(noteFilesIds.length, (index) {
        String fileId = noteFilesIds[index];
        String fileName = fileData[fileId];

        return FileItem(fileId: fileId, fileName: fileName, where: where, hideOptions: hideOptions);
      }),
    );
  }
}
