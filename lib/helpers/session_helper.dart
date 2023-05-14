import 'dart:collection';

Map sortSessionsByTime(Map daySessionsMap) {
  Map mapOfTimeToSessions = {};
  daySessionsMap.forEach((key, value) {
    mapOfTimeToSessions[int.parse(value['time'].toString().replaceAll(RegExp(r':'), ''))] = value.toString();
  });
  Map sortedMapOfTimeToSessions = SplayTreeMap<int, String>.from(mapOfTimeToSessions, (k1, k2) => k1.compareTo(k2));
  return sortedMapOfTimeToSessions;
}
