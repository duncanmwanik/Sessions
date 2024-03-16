import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';

import '../../../../_config/styling/styler.dart';
import '../../../../_providers/_provider_variables.dart';
import '../../../../_widgets/components/checkbox.dart';
import '../../../../_widgets/components/icons.dart';

class TaskEntry extends StatefulWidget {
  const TaskEntry({Key? key, required this.entryId, required this.entryData}) : super(key: key);

  final String entryId;
  final Map entryData;

  @override
  State<TaskEntry> createState() => _TaskEntryState();
}

class _TaskEntryState extends State<TaskEntry> {
  FocusNode entryFocusNode = FocusNode();
  bool isChecked = false;
  bool showDeleteButton = false;
  String previousTitle = '';

  @override
  void initState() {
    setState(() {
      previousTitle = widget.entryData['t'] ?? '';
      isChecked = widget.entryData['v'] == '1';
    });

    entryFocusNode.addListener(() => setState(() => showDeleteButton = entryFocusNode.hasFocus));

    super.initState();
  }

  @override
  void dispose() {
    entryFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isNewEntry = taskInputProviderX.newEntryId == widget.entryId;
    bool isSubtitle = widget.entryData['v'] == 's';
    bool isText = widget.entryData['v'] == 't';

    return MouseRegion(
      onEnter: (_) => setState(() => showDeleteButton = true),
      onExit: (_) => setState(() => showDeleteButton = false),
      child: InkWell(
        // onTap: () => entryFocusNode.requestFocus(),
        focusColor: styler.transparent,
        hoverColor: styler.transparent,
        splashColor: styler.transparent,
        highlightColor: styler.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              // Checkbox
              //
              if (!isSubtitle && !isText)
                CheckBoxOverview(
                    isChecked: isChecked,
                    onTap: () {
                      setState(() => isChecked = !isChecked);
                      taskInputProviderX.updateEntryValue(widget.entryId, isChecked ? '1' : '0');
                    }),
              //
              if (!isSubtitle && !isText) smallSpacerWidth(),
              //
              // Entry Text
              //
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: kIsWeb ? 10 : 5.5),
                  child: TextFormField(
                    onChanged: (value) => taskInputProviderX.updateEntryName(widget.entryId, value.trim()),
                    // onFieldSubmitted: (_) {
                    //   entryFocusNode.unfocus();
                    //   if (isNewEntry) {
                    //     addNewEntry();
                    //   }
                    // },
                    initialValue: widget.entryData['t'],
                    focusNode: entryFocusNode,
                    autofocus: isNewEntry,
                    minLines: 1,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: textSizeNormal,
                      fontWeight: isSubtitle ? FontWeight.w500 : FontWeight.w400,
                      color: styler.textColor(),
                      decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ),
              //
              // Delete Button
              //
              AppIconButton(
                Icons.close_rounded,
                noPadding: true,
                onPressed: showDeleteButton ? () => taskInputProviderX.removeEntryFromInputData(widget.entryId) : null,
                color: showDeleteButton ? styler.textColorFaded() : styler.transparent,
                tiny: true,
              ),
              //
              //
              //
            ],
          ),
        ),
      ),
    );
  }
}
