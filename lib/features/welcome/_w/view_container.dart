import 'package:flutter/material.dart';

import '../../../_config/styling/styler.dart';

class ViewContainer extends StatelessWidget {
  const ViewContainer({Key? key, required this.children}) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        Spacer(),
        //
        Container(
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
            color: styler.appColor(2),
            borderRadius: BorderRadius.circular(borderRadiusMedium),
          ),
          child: Column(
            children: children,
          ),
        ),
        //
        Spacer(),
        //
      ],
    );
  }
}
