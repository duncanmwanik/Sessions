import 'package:flutter/material.dart';

import '../../../../../_config/styling/spacing.dart';
import '../../../../../_variables/common_variables.dart';

class SessionColorItem extends StatelessWidget {
  const SessionColorItem({Key? key, required this.index, required this.onPressed}) : super(key: key);

  final int index;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: sessionColorList[index].color,
        minimumSize: minSizeZero(),
        fixedSize: Size(50, 50),
        side: BorderSide.none,
        shape: CircleBorder(),
      ),
      onPressed: onPressed,
      child: null,
    );
  }
}
