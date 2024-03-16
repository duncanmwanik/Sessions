import 'package:flutter/material.dart';

const String chooseColorText = 'Pick a Color';

FocusNode noteTextFocusNode = FocusNode();
FocusNode taskEntryFocusNode = FocusNode();

// import 'package:bot_toast/bot_toast.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:sessions/_widgets/components/icons.dart';
// import 'package:styled_text/styled_text.dart';

// import '../../_config/styling/spacing.dart';
// import '../../_config/styling/styler.dart';
// import '../../_config/styling/styles.dart';

// void showToast(int type, String message, {int duration = 3}) {
//   late CancelFunc cancel;

//   void closeToast() {
//     cancel();
//   }

//   cancel = BotToast.showAttachedWidget(
//     allowClick: true,
//     ignoreContentClick: kIsWeb,
//     target: Offset(0, 0),
//     duration: Duration(seconds: duration),
//     attachedBuilder: (_) => Align(
//       alignment: Alignment.topCenter,
//       child: Container(
//         constraints: BoxConstraints(maxWidth: 380),
//         color: Colors.red,
//         child: Material(
//           color: styler.transparent,
//           //
//           // Overlay solves JusTheToolTip overlay missing problem
//           //
//           child: Overlay(
//             initialEntries: [
//               OverlayEntry(
//                 builder: (context) => Container(
//                   margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: kIsWeb ? 10 : 0),
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   decoration: BoxDecoration(
//                     color: styler.toastBackgroundColor(),
//                     borderRadius: BorderRadius.circular(borderRadiusSmall),
//                     border: styler.lightBoxBorder(),
//                   ),
//                   child: Container(
//                     color: Colors.blue,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.max,
//                       children: <Widget>[
//                         //
//                         //
//                         Flexible(
//                           child: Row(
//                             children: [
//                               //
//                               //
//                               AppIcon(toastIcons[type], color: AppColors.toastColors[type]),
//                               //
//                               mediumSpacerWidth(),
//                               //
//                               // Message
//                               //
//                               Flexible(
//                                 child: StyledText(
//                                   text: message,
//                                   style: TextStyle(fontSize: textSizeMedium, fontWeight: FontWeight.w500, color: styler.black),
//                                   tags: {
//                                     'b': StyledTextTag(style: TextStyle(fontSize: textSizeMedium, fontWeight: FontWeight.bold, color: styler.black)),
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         //
//                         // Close Toast
//                         //
//                         AppIconButton(
//                           onPressed: () => closeToast(),
//                           Icons.close,
//                           color: Colors.black45,
//                         ),
//                         //
//                         //
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }
