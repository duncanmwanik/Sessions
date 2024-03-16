Map sortSessionsByTime(Map sessionsMap) {
  Map mapOfKeysToTime = {};
  Map finalSortedMap = {};

  sessionsMap.forEach((key, value) {
    mapOfKeysToTime[key] = int.parse(value['s'].toString().replaceAll(':', ''));
  });
  Map sortedByTimeMap = Map.fromEntries(mapOfKeysToTime.entries.toList()..sort((a, b) => a.value.compareTo(b.value)));
  sortedByTimeMap.forEach((key, value) {
    finalSortedMap[key] = sessionsMap[key];
  });

  return finalSortedMap;
}
