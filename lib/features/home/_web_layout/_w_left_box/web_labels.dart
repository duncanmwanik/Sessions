import 'package:flutter/material.dart';

import '../../../labels/label_manager.dart';

class WebLabels extends StatelessWidget {
  const WebLabels({Key? key, this.isPopable = false}) : super(key: key);

  final bool isPopable;

  @override
  Widget build(BuildContext context) {
    return LabelManager(isPopable: isPopable);
  }
}
