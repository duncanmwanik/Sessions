import 'package:flutter/material.dart';
import 'package:sessions/_helpers/_common_helpers/global_helper.dart';
import 'package:sessions/_providers/_provider_variables.dart';
import 'package:sessions/_widgets/components/text_styles.dart';

import '../../_config/styling/styler.dart';
import '../../_helpers/_common_helpers/theme_helper.dart';
import '../components/icons.dart';

class ThemeItem extends StatefulWidget {
  const ThemeItem({Key? key, required this.themeImage, required this.themeType}) : super(key: key);

  final String themeImage;
  final String themeType;

  @override
  State<ThemeItem> createState() => _ThemeItemState();
}

class _ThemeItemState extends State<ThemeItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    Color color = widget.themeType == 'light' ? styler.black : styler.white;
    bool isSelected = widget.themeImage == themeProviderX.themeImage;

    return InkWell(
      onTap: () {
        popWhatsOnTop();
        themeProviderX.setThemeImage(widget.themeImage, widget.themeType);
      },
      onHover: (value) => setState(() => isHovered = value),
      borderRadius: BorderRadius.circular(borderRadiusSmall + 3),
      child: Container(
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadiusSmall + 3),
          image: DecorationImage(
            image: AssetImage(getThemeImage(widget.themeImage)),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //
            AppText(size: small, text: '${widget.themeImage.substring(0, 1).toUpperCase()}${widget.themeImage.substring(1)}', textColor: color),
            //
            //
            if (isSelected) AppIcon(Icons.done_rounded, color: color),
            if (isHovered && !isSelected) AppIcon(Icons.lens, color: color, size: small),
            //
          ],
        ),
      ),
    );
  }
}
