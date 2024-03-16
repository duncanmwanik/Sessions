import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';

import '../../../_config/styling/styler.dart';
import '../../../_widgets/components/icons.dart';

class PinnedIcon extends StatelessWidget {
  const PinnedIcon({Key? key, required this.bgColor}) : super(key: key);
  final String bgColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: itemPadding(left: true),
      child: Transform.rotate(
        angle: 0.523599,
        child: AppIcon(Icons.push_pin, size: 14, color: styler.accentColor()),
      ),
    );
  }
}
