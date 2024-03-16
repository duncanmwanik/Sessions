import 'package:hive_flutter/hive_flutter.dart';

import '../../_tables/_helpers/get_table_data.dart';

String getFlagColor(String flag) {
  try {
    return Hive.box('${currentSelectedTable()}_flags').get(flag, defaultValue: '0');
  } catch (_) {
    return '0';
  }
}
