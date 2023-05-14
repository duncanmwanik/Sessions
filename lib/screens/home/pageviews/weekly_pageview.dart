import 'package:flutter/material.dart';

import '../../../models/session_model.dart';
import '../../sessions/widgets/session_widget.dart';

class WeeklyPageView extends StatelessWidget {
  const WeeklyPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Text(
            'WEEKLY',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
          ),

          SessionWidget(
            session: sessionObject,
          ),
          // ListView.builder(
          //     shrinkWrap: true,
          //     physics: NeverScrollableScrollPhysics(),
          //     itemCount: 24,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
          //         child: Row(
          //           children: [
          //             Text(
          //               '${hours24to12[index] ?? 00} ',
          //               style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black38),
          //             ),
          //             Expanded(
          //                 child: Divider(
          //               thickness: 2,
          //             ))
          //           ],
          //         ),
          //       );
          //     }),
        ],
      ),
    );
  }
}
