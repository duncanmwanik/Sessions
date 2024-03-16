import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sessions/_config/styling/breakpoints.dart';
import 'package:sessions/_widgets/components/loader.dart';

import '../../_config/styling/spacing.dart';
import '../../_config/styling/styler.dart';
import '../../_helpers/_common_helpers/global_helper.dart';
import 'icons.dart';
import 'images.dart';
import 'text_styles.dart';

//
//
//

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.label,
    this.onPressed,
    this.iconData,
    this.imagePath,
    this.color,
    this.showLoading = false,
  }) : super(key: key);
  final String label;
  final Function()? onPressed;
  final IconData? iconData;
  final String? imagePath;
  final Color? color;
  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(300, 40),
              backgroundColor: color ?? (styler.isDarkTheme ? styler.itemColor() : styler.white),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusSmall)),
              side: styler.lightButtonBorder(),
            ),
            onPressed: onPressed ?? () {},
            child: showLoading
                ? AppLoader()
                : iconData != null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppIcon(
                            iconData,
                            size: 18,
                            color: color != null ? styler.white : null,
                          ),
                          smallSpacerWidth(),
                          Flexible(
                              child: AppText(
                            size: normal,
                            text: label,
                            textColor: color != null ? styler.white : null,
                            fontWeight: color != null ? FontWeight.w600 : null,
                            overflow: TextOverflow.visible,
                          )),
                        ],
                      )
                    : imagePath != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (imagePath != null) AppImage(imagePath: imagePath ?? '', size: imageSizeTiny),
                              if (imagePath != null) mediumSpacerWidth(),
                              Flexible(
                                  child: AppText(
                                size: medium,
                                text: label,
                                textColor: color != null ? styler.white : null,
                                fontWeight: color != null ? FontWeight.w600 : null,
                                overflow: TextOverflow.visible,
                              )),
                            ],
                          )
                        : AppText(
                            size: normal,
                            text: label,
                            textColor: color != null ? styler.white : null,
                            fontWeight: color != null ? FontWeight.w600 : null,
                            overflow: TextOverflow.visible,
                          ),
          ),
        ),
      ],
    );
  }
}

//
//
//

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.color,
    this.isRound = false,
    this.smallPadding = false,
    this.smallLeftPadding = false,
    this.noStyling = false,
  }) : super(key: key);

  final Function()? onPressed;
  final Widget child;
  final Color? color;
  final bool isRound;
  final bool smallLeftPadding;
  final bool smallPadding;
  final bool noStyling;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: noStyling ? styler.transparent : color ?? (styler.isDarkTheme ? styler.itemColor() : styler.transparent),
        side: noStyling ? null : styler.lightButtonBorder(),
        padding: isRound
            ? EdgeInsets.all(kIsWeb && !smallPadding ? 15 : 6)
            : EdgeInsets.only(
                left: smallLeftPadding ? 7 : 12,
                right: 12,
                top: isNotPhone() ? 15 : 6,
                bottom: isNotPhone() ? 15 : 6,
              ),
        shape: isRound
            ? CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadiusMedium),
              ),
        minimumSize: Size(0, 30),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}

//
//
//

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    this.onPressed,
    required this.label,
    this.icon,
    this.isAuth = false,
    this.isEndIcon = false,
    this.isLargeText = false,
  }) : super(key: key);

  final Function()? onPressed;
  final String label;
  final IconData? icon;
  final bool isAuth;
  final bool isEndIcon;
  final bool isLargeText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: styler.transparent,
            side: BorderSide.none,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusLarge)),
            minimumSize: minSizeZero(),
          ),
          onPressed: onPressed ?? () {},
          child: Row(
            children: [
              if (icon != null && !isEndIcon) AppIcon(icon, faded: true, size: 18, color: isAuth ? styler.white : null),
              if (icon != null && !isEndIcon) tinySpacerWidth(),
              AppText(size: isLargeText ? normal : medium, text: label, textColor: isAuth ? styler.white : null, faded: !isAuth),
              if (icon != null && isEndIcon) tinySpacerWidth(),
              if (icon != null && isEndIcon) AppIcon(icon, faded: true, size: 18, color: isAuth ? styler.white : null),
            ],
          ),
        )
      ],
    );
  }
}

//
//
//

class SaveButton extends StatelessWidget {
  const SaveButton({Key? key, required this.onPressed, this.label, this.isCancel = false}) : super(key: key);

  final Function() onPressed;
  final String? label;
  final bool isCancel;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isCancel ? Colors.grey : styler.accentColor(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusMedium)),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: kIsWeb ? 12 : 6),
        minimumSize: Size(30, 35),
      ),
      child: AppText(size: medium, text: label ?? (isCancel ? 'Cancel' : 'Save'), textColor: styler.white, fontWeight: FontWeight.w600),
    );
  }
}

//
//
//

class AppTextButton extends StatelessWidget {
  const AppTextButton({Key? key, required this.onPressed, required this.label, this.fontSize, this.shrunk = false, this.faded = false}) : super(key: key);

  final Function() onPressed;
  final String label;
  final double? fontSize;
  final bool shrunk;
  final bool faded;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: shrunk ? 5 : 0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadiusLarge)),
        tapTargetSize: shrunk ? MaterialTapTargetSize.shrinkWrap : null,
        minimumSize: shrunk ? minSizeZero() : null,
      ),
      child: AppText(size: fontSize, text: label, faded: faded),
    );
  }
}

//
//
//

class CustomCloseButton extends StatelessWidget {
  const CustomCloseButton({
    Key? key,
    this.onPressed,
    this.faded = false,
    this.isX = false,
    this.color,
  }) : super(key: key);

  final Function()? onPressed;
  final bool faded;
  final bool isX;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed ?? () => popWhatsOnTop(),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.zero,
        backgroundColor: styler.transparent,
        minimumSize: minSizeZero(),
        fixedSize: kIsWeb ? Size(30, 30) : Size(40, 40),
      ),
      child: AppIcon(
        isX ? Icons.close_rounded : Icons.arrow_back_rounded,
        color: color ?? (faded ? styler.textColorFaded() : styler.textColor()),
        large: true,
      ),
    );
  }
}

//
//
//
