import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_providers/_provider_variables.dart';
import 'package:sessions/_widgets/dialogs/app_dialog.dart';
import 'package:sessions/_widgets/others/other_widgets.dart';
import 'package:sessions/features/_lists/_state/board_input_provider.dart';
import 'package:sessions/features/_lists/_w_list/list_files.dart';
import 'package:sessions/features/labels/bottom_sheet_labels.dart';

import '../../../_config/styling/spacing.dart';
import '../../../_config/styling/styler.dart';
import '../../../_helpers/_common_helpers/global_helper.dart';
import '../../../_widgets/components/icons.dart';
import '../../../_widgets/dialogs/action_buttons.dart';
import '../../../_widgets/dialogs/dialog_item_bg_color.dart';
import '../../files/_helpers/upload_files.dart';
import '../_helpers/list/create_list.dart';
import '../_helpers/list/edit_list.dart';
import 'list_labels.dart';

Future showCreateListDialog({bool isEdit = false, Map? listData, String? listId}) {
  if (isEdit && listData != null) {
    listInputProviderX.updateAllInputData(listData);
  } else {
    listInputProviderX.clearData();
  }

  return showAppDialog(
    //
    //
    //
    content: Consumer<ListInputProvider>(builder: (context, inputProvider, child) {
      bool isPinned = (inputProvider.listInputData['p'] ?? '0') == '1';
      String color = inputProvider.listInputData['c'] ?? '';

      return ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        children: [
          //
          // List Name Editing
          //
          Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: TextFormField(
              onChanged: (value) => listInputProviderX.addToListInputData('t', value),
              autofocus: !isEdit,
              initialValue: listData != null ? listData['t'] : null,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              minLines: 2,
              maxLines: 3,
              style: TextStyle(fontSize: textSizeNormal, fontWeight: FontWeight.w500, color: styler.textColor()),
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: TextStyle(fontSize: textSizeNormal, fontWeight: FontWeight.w500),
                filled: true,
                fillColor: styler.itemColor(isDialog: true),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadiusSmall), borderSide: BorderSide.none),
              ),
            ),
          ),
          //
          smallSpacerHeight(),
          //
          // Options
          //
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              // Change List Color
              //
              AppIconButton(
                onPressed: () async {
                  hideKeyboard();
                  await showPickItemBgColor(color: color).then((color) async {
                    if (color != null) {
                      inputProvider.addToListInputData('c', color);
                    }
                  });
                },
                Icons.palette_outlined,
                faded: true,
              ),
              //
              // Pin List
              //
              AppIconButton(
                onPressed: () {
                  hideKeyboard();
                  if (isPinned) {
                    inputProvider.addToListInputData('p', '0');
                  } else {
                    inputProvider.addToListInputData('p', '1');
                  }
                },
                isPinned ? Icons.push_pin_rounded : Icons.push_pin_outlined,
                faded: true,
              ),
              //
              // Add labels
              //
              AppIconButton(
                onPressed: () async {
                  hideKeyboard();
                  List currentLabels = listInputProviderX.listInputData['l'] != null ? getSplitList(listInputProviderX.listInputData['l'].toString()) : [];
                  await showLabelsBottomSheet(isSelection: true, alreadySelected: currentLabels).then((labelList) {
                    if (labelList != null && labelList.isNotEmpty) {
                      listInputProviderX.addToListInputData('l', getJoinedList(labelList));
                    } else {}
                  });
                },
                Icons.label_outlined,
                faded: true,
              ),
              //
              // Add attachments
              //
              AppIconButton(
                onPressed: () => getFilesToUpload(where: 'lists'),
                Icons.attach_file_rounded,
                faded: true,
                tiny: true,
              ),
              //
            ],
          ),
          //
          if (hasItemColor(color)) smallSpacerHeight(),
          //
          // Color Container
          //
          if (hasItemColor(color))
            ColorContainer(
              bgColor: color,
              onTap: () async {
                hideKeyboard();
                await showPickItemBgColor(color: color).then((color) async {
                  if (color != null) {
                    inputProvider.addToListInputData('c', color);
                  }
                });
              },
            ),
          //
          smallSpacerHeight(),
          //
          // Selected Labels List
          //
          ListLabels(),
          //
          // list attachments
          //
          ListFiles(),
          //
          //
          //
        ],
      );
    }),
    //
    //
    //
    actions: [
      //
      DialogActionButtonCancel(),
      //
      DialogActionButtonAccept(
        label: isEdit ? 'Save' : 'Create',
        onPressed: () async {
          //
          hideKeyboard();
          //
          if (isEdit && listId != null) {
            await editList(listId, listInputProviderX.listInputData);
          } else {
            await createNewList(listInputProviderX.listInputData);
          }
        },
      ),
      //
    ],
    //
  );
}
