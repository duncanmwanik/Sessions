import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_widgets/others/other_widgets.dart';

import '../../../../_helpers/_common_helpers/global_helper.dart';
import '../../../../_widgets/components/icons.dart';
import '../../../../_widgets/dialogs/dialog_item_bg_color.dart';
import '../../files/_helpers/upload_files.dart';
import '../_state/task_input_provider.dart';

class TaskFooter extends StatelessWidget {
  const TaskFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskInputProvider>(builder: (context, inputProvider, child) {
      String bgcolor = inputProvider.taskInputData['c'] ?? '';

      return Row(
        children: [
          //
          // Add attachment
          //
          AppIconButton(
            onPressed: () async {
              await getFilesToUpload(where: 'tasks');
            },
            Icons.attach_file_rounded,
            faded: true,
          ),
          //
          // Change note color
          //
          AppIconButton(
            onPressed: () async {
              await showPickItemBgColor(color: bgcolor).then((color) async {
                if (color != null) {
                  inputProvider.addToTaskInputData('c', color);
                }
              });
            },
            Icons.palette_outlined,
            faded: true,
          ),
          // Color Container
          Expanded(
            child: hasItemColor(bgcolor)
                ? ColorContainer(
                    bgColor: inputProvider.taskInputData['c'],
                    onTap: () async {
                      await showPickItemBgColor(color: bgcolor).then((color) async {
                        if (color != null) {
                          inputProvider.addToTaskInputData('c', color);
                        }
                      });
                    },
                  )
                : NoWidget(),
          ),
          //
          // More options
          // TODO: Add More options
          AppIconButton(
            onPressed: () {},
            Icons.more_vert_rounded,
            faded: true,
          ),
          //
          //
          //
        ],
      );
    });
  }
}
