import 'package:flutter/material.dart';

import '../../_config/styling/styler.dart';

class AppImage extends StatelessWidget {
  const AppImage({Key? key, required this.imagePath, this.size = imageSizeLarge}) : super(key: key);

  final String imagePath;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      height: size,
      width: size,
    );
  }
}
