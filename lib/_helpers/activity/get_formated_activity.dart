import '../date_time/date_info.dart';

Map activityTypes = {
  't0': 'created table',
  't1': 'edited table',
  't2': 'added admin',
  't3': 'removed admin',
  's0': 'created session',
  's1': 'edited session',
  's2': 'deleted session',
  's3': 'copied session',
  's4': 'moved session',
  'n0': 'created note',
  'n1': 'edited note',
  'n2': 'deleted note',
  'k0': 'created task',
  'k1': 'edited task',
  'k2': 'deleted task',
  'b0': 'created list',
  'b1': 'edited list',
  'b2': 'deleted list',
  'bi0': 'created an item',
  'bi1': 'edited items',
  'bi2': 'deleted an item',
};

Map timeTypes = {
  't0': 'on',
  't1': 'on',
  't2': 'on',
  't3': 'on',
  's0': 'for the date',
  's1': 'for the date',
  's2': 'from the date',
  's3': 'to',
  's4': 'to',
};

Map itemTypesSession = {
  't': 'title',
  'l': 'lead',
  'v': 'venue',
  'a': 'description',
  's': 'start time',
  'e': 'end time',
  'y': 'type',
  'c': 'color',
};

Map itemTypesTable = {
  't': 'title',
  'a': 'description',
  's': 'start date',
  'e': 'end date',
};

String replaceLast(String string, String substring, String replacement) {
  int index = string.lastIndexOf(substring);
  if (index == -1) {
    return string;
  }
  return string.substring(0, index) + replacement + string.substring(index + substring.length);
}

String getActivityText(String timestamp, String activity) {
  try {
    List activityData = activity.split(',');
    String action = activityData[0];
    String type = activity.substring(0, 1);
    List items = [];
    List dates = [];

    if (action == 't0') {
      return '<b>${activityData[1]}</b> ${activityTypes[action]}.';
    }
    //
    else if (action == 't1') {
      activityData[2].toString().split('/').forEach((element) {
        items.add(itemTypesTable[element]);
      });
      return '<b>${activityData[1]}</b> ${activityTypes[action]} ${items.join(',')}.';
    }
    //
    else if (action == 's0') {
      activityData[3].toString().split('/').forEach((element) => dates.add(getDayInfo(element)));
      String dateString = dates.length == 1 ? '${dates.first}' : dates.join('/');
      return '<b>${activityData[1]}</b> ${activityTypes[action]} <b>${activityData[4]}</b> ${timeTypes[action]} <b>$dateString</b>.';
    }
    //
    else if (action == 's1') {
      activityData[5].toString().split('-').forEach((element) => items.add(itemTypesSession[element]));
      String itemString = items.length == 1 ? '${items.first}' : replaceLast(items.join(','), ',', ' & ');
      return '<b>${activityData[1]}</b> ${activityTypes[action]} <b>$itemString</b> for <b>${activityData[4]}</b> ${timeTypes[action]} <b>${activityData[3]}</b>.';
    }
    //
    else if (['n', 't', 'b'].contains(type)) {
      return '<b>${activityData[1]}</b> ${activityTypes[action]} <b>${activityData[3]}</b>.';
    }
    //
    else if (['n', 't', 'b'].contains(type)) {
      return '<b>${activityData[1]}</b> ${activityTypes[action]} <b>${activityData[3]}</b>.';
    }
    //
    else if (['n', 't', 'b'].contains(type)) {
      return '<b>${activityData[1]}</b> ${activityData[4] == '1' ? 'pinned' : 'unpinned'} ${type == 'n' ? 'note' : 'task'} <b>${activityData[3]}</b>.';
    }
    //
    else if (['bi0', 'bi1', 'bi2'].contains(action)) {
      return '<b>${activityData[1]}</b> ${activityTypes[action]} in the list <b>${activityData[3]}</b>.';
    }
    //
    else {
      return '<b>${activityData[1]}</b> ${activityTypes[action]} <b>${activityData[4]}</b> ${timeTypes[action]} <b>${activityData[3]}</b>.';
    }
  } catch (e) {
    return 'New changes were made recently.';
  }
}
