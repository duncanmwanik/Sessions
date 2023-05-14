import 'package:flutter/material.dart';

import '../variables/global_variables.dart';

void getDeviceScreenDimensions(BuildContext context) {
  // get device screen size and save them globally
  h = MediaQuery.of(context).size.height;
  w = MediaQuery.of(context).size.width;
}
