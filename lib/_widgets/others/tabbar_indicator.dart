import 'package:flutter/material.dart';

import '../../_config/styling/styler.dart';

class CustomTabBarIndicator extends Decoration {
  const CustomTabBarIndicator();

  @override
  IndicatorPainter createBoxPainter([VoidCallback? onChanged]) {
    return IndicatorPainter(this, onChanged!);
  }
}

class IndicatorPainter extends BoxPainter {
  final CustomTabBarIndicator decoration;

  IndicatorPainter(this.decoration, VoidCallback onChanged) : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);

    Rect rect = Offset(offset.dx + 6, (configuration.size!.height - 3)) & Size(configuration.size!.width - 12, 3);

    final Paint paint = Paint();
    paint.color = styler.accentColor();
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(8)), paint);
  }
}
