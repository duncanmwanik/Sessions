import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sessions/_widgets/components/icons.dart';
import 'package:sessions/_widgets/others/other_widgets.dart';

import '../../_services/hive/local_storage_service.dart';

class CloudSyncIndicator extends StatefulWidget {
  const CloudSyncIndicator({Key? key}) : super(key: key);

  @override
  State<CloudSyncIndicator> createState() => _CloudSyncIndicatorState();
}

class _CloudSyncIndicatorState extends State<CloudSyncIndicator> with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> animation = CurvedAnimation(
    parent: controller,
    curve: Curves.linear,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: globalBox.listenable(),
        builder: (context, box, widget) {
          bool showLoader = box.get('showUpdateLoader', defaultValue: false);

          if (showLoader) {
            controller.repeat();
          } else {
            controller.stop();
          }

          return showLoader
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RotationTransition(turns: animation, child: AppIcon(FontAwesomeIcons.rotate, faded: true, size: 16)),
                )
              : NoWidget();
        });
  }
}
