import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../_config/styling/styler.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({Key? key, this.size = 16}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(color: styler.accentColor(), size: size);
  }
}
