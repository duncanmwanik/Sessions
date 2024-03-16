import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../_config/styling/spacing.dart';

class SvgImage extends StatelessWidget {
  const SvgImage({Key? key, required this.imagePath, this.isSmall = false, this.isTiny = false, this.isSignInImage = false}) : super(key: key);

  final String imagePath;
  final bool isSmall;
  final bool isTiny;
  final bool isSignInImage;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      imagePath,
      semanticsLabel: 'Sessions',
      height: isTiny
          ? 80
          : isSmall
              ? 120
              : isSignInImage
                  ? 20
                  : imageHeight(),
      width: isTiny
          ? 80
          : isSmall
              ? 150
              : isSignInImage
                  ? 20
                  : imageHeight(),
    );
  }
}
