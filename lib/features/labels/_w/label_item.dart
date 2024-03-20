import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';
import 'package:sessions/_providers/_provider_variables.dart';
import 'package:sessions/_widgets/components/icons.dart';
import 'package:sessions/features/labels/_helpers/delete_label.dart';

import '../../../_config/styling/styler.dart';
import '../../../_widgets/components/checkbox.dart';
import '../../../_widgets/components/text_styles.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../_state/labels_provider.dart';

class LabelItem extends StatefulWidget {
  const LabelItem({
    Key? key,
    required this.label,
    this.isSelection = false,
    this.isPopable = false,
  }) : super(key: key);

  final String label;
  final bool isSelection;
  final bool isPopable;

  @override
  State<LabelItem> createState() => _LabelItemState();
}

class _LabelItemState extends State<LabelItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.label == labelsProviderX.selectedLabel;

    return Dismissible(
      key: UniqueKey(),
      confirmDismiss: (direction) => showConfirmationDialog(title: 'Delete label: <b>${widget.label}</b>?', yeslabel: 'Delete').then((value) => value),
      onDismissed: (direction) => deleteLabel(widget.label),
      background: Container(color: styler.appColor(1)),
      child: Material(
        color: styler.transparent,
        child: ListTile(
          onTap: () {
            // add label to selection
            if (widget.isSelection) {
              if (labelsProviderX.selectedLabelList.contains(widget.label)) {
                labelsProviderX.removeFromLabelList(widget.label);
              } else {
                labelsProviderX.addToLabelList(widget.label);
              }
            }
            // select label
            else {
              labelsProviderX.updateSelectedLabel(widget.label);
              if (widget.isPopable) {
                popWhatsOnTop();
              }
            }
            //
          },
          dense: true,
          horizontalTitleGap: -8,
          tileColor: isSelected ? styler.appColor(1) : null,
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 1),
          //
          leading: widget.isSelection
              ? Consumer<LabelsProvider>(builder: (context, labelsProvider, child) {
                  return CheckBoxOverview(
                    isChecked: labelsProvider.selectedLabelList.contains(widget.label),
                    isTiny: true,
                    onTap: () {
                      // add label to selection
                      if (labelsProviderX.selectedLabelList.contains(widget.label)) {
                        labelsProviderX.removeFromLabelList(widget.label);
                      } else {
                        labelsProviderX.addToLabelList(widget.label);
                      }
                      //
                    },
                  );
                })
              : AppIcon(isSelected ? Icons.label_rounded : Icons.label_outlined, size: 16),
          //
          // Label Text
          //
          title: AppText(size: medium, text: widget.label, fontWeight: FontWeight.w400, faded: true, overflow: TextOverflow.visible),
          //
        ),
      ),
    );
  }
}
