import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../_config/styling/breakpoints.dart';
import '../../../../../_config/styling/styler.dart';
import '../../../../../_variables/common_variables.dart';
import '../../../../../_widgets/components/text_styles.dart';

class SessionTypeItem extends StatelessWidget {
  const SessionTypeItem({Key? key, required this.index, required this.onPressed}) : super(key: key);

  final int index;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: styler.itemColor(),
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: isNotPhone() ? 15 : 6,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusMedium),
        ),
        minimumSize: Size(0, kIsWeb ? 42 : 30),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: AppText(size: medium, text: sessionTypeList[index]),
    );
  }
}
