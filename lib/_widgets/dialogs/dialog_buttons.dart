import 'package:flutter/material.dart';

import '../../_config/styling/styler.dart';
import '../../_helpers/_common_helpers/global_helper.dart';

class DialogActionButtonAccept extends StatelessWidget {
  const DialogActionButtonAccept({Key? key, this.label, this.onPressed}) : super(key: key);

  final String? label;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: styler.dialogButtonColor(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusMedium)),
      ),
      onPressed: onPressed ?? () => popWhatsOnTop(),
      child: Text(label ?? 'Done', style: TextStyle(fontWeight: FontWeight.w500, fontSize: textSizeMedium, color: styler.white)),
    );
  }
}

class DialogActionButtonCancel extends StatelessWidget {
  const DialogActionButtonCancel({Key? key, this.label, this.onPressed}) : super(key: key);

  final String? label;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: styler.dialogButtonColor(isCancel: true),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusMedium)),
      ),
      onPressed: onPressed ?? () => popWhatsOnTop(),
      child: Text(
        label ?? 'Cancel',
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: textSizeMedium, color: styler.white),
      ),
    );
  }
}
