import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/spacing.dart';
import 'package:sessions/_widgets/components/text_styles.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({Key? key, this.label = 'No items', this.isSpaced = true}) : super(key: key);

  final String label;
  final bool isSpaced;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        //
        if (isSpaced) smallPlaceHolderSpacerHeight(),
        //
        //
        //
        Image.asset(
          'assets/images/empty.png',
          height: smallImageHeight(),
          width: smallImageHeight(),
        ),
        //
        //
        mediumSpacerHeight(),
        //
        //
        //
        AppText(size: medium, text: label, faded: true, textAlign: TextAlign.center),
        //
      ],
    );
  }
}
