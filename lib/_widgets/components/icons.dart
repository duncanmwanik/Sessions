import 'package:flutter/material.dart';
import 'package:sessions/_widgets/components/tooltip.dart';

import '../../_config/styling/spacing.dart';
import '../../_config/styling/styler.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(
    this.iconData, {
    Key? key,
    this.color,
    this.size,
    this.tiny = false,
    this.large = false,
    this.faded = false,
  }) : super(key: key);

  final IconData? iconData;
  final Color? color;
  final double? size;
  final bool tiny;
  final bool large;
  final bool faded;

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      size: size ??
          (large
              ? 24
              : tiny
                  ? 20
                  : 22),
      color: color ?? (faded ? styler.textColorFaded() : styler.textColor()),
      opticalSize: 5,
    );
  }
}

class AppIconButton extends StatelessWidget {
  const AppIconButton(
    this.iconData, {
    Key? key,
    this.color,
    this.size,
    this.noPadding = false,
    this.tiny = false,
    this.large = false,
    this.smallSize = false,
    this.largeSize = false,
    this.faded = false,
    this.tooltip,
    required this.onPressed,
  }) : super(key: key);

  final IconData iconData;
  final Color? color;
  final double? size;
  final Function()? onPressed;
  final bool noPadding;
  final bool tiny;
  final bool large;
  final bool largeSize;
  final bool smallSize;
  final bool faded;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return AppTooltip(
      message: tooltip ?? '',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: noPadding ? 0 : 8),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.zero,
            backgroundColor: styler.transparent,
            disabledBackgroundColor: styler.transparent,
            minimumSize: minSizeZero(),
            fixedSize: largeSize
                ? Size(40, 40)
                : smallSize
                    ? Size(25, 25)
                    : Size(30, 30),
            side: BorderSide.none,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: AppIcon(
            iconData,
            size: large
                ? 24
                : tiny
                    ? 20
                    : size ?? iconSize(),
            color: color ?? (faded ? styler.textColorFaded() : styler.textColor()),
          ),
        ),
      ),
    );
  }
}
