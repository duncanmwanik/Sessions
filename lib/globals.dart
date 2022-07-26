import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

String userId = '--';

String version = "alpha";
bool update = false;

DatabaseReference db = FirebaseDatabase.instance.reference();

String defaultImage = 'https://firebasestorage.googleapis.com/v0/b/sessions-e4256.appspot.com/o/app_files%2Fdef'
    'ault.jpg?alt=media&token=5cd1c0d2-56e6-42f2-8b5a-1453fd012a3e';

String sessionImage = "https://firebasestorage.googleapis.com/v0/b/sessions-mo.appspot.com/o/app%20images%2"
    "Fsession.jpg?alt=media&token=b6f17bbf-187c-4289-a757-ae8d8641bde9";

String tableImage = "https://images.unsplash.com/photo-1506784365847-bbad939e9335?ixlib=rb-1.2.1&ixid=MnwxM"
    "jA3fDB8MHxwaG90by1yZWxhdGVkfDN8fHxlbnwwfHx8fA%3D%3D&auto=format&fit=crop&w=500&q=60";

String errorImage = "https://firebasestorage.googleapis.com/v0/b/sessions-e4256.appspot.com/o/app_files%2Ferr"
    "or.gif?alt=media&token=502fc3f1-0278-4cbd-89bb-5b960ce418f2";

String emptyImage = "https://firebasestorage.googleapis.com/v0/b/sessions-e4256.appspot.com/o/app_files%2Fempty."
    "gif?alt=media&token=6c6c10a2-6255-48f2-a3c4-48c3e16c2f1f";

String welcomeImage = "https://firebasestorage.googleapis.com/v0/b/sessions-e4256.appspot.com/o/app_"
    "files%2Fwelcome.jpg?alt=media&token=198ae725-db8f-447b-83e3-0f7eda02903b";

String drawerImage = "https://firebasestorage.googleapis.com/v0/b/sessions-e4256.appspot.com/o/app_files%2Fdrawer.jpg?alt=media&token=89223c40-d99f-4fdb-b805-6002836546f2";
String drawer2Image = "https://firebasestorage.googleapis.com/v0/b/sessions-e4256.appspot.com/o/app_files%2Fdrawer2.png?alt=media&token=18263eec-d975-4939-b261-6d893585116c";
String expandedImage = "https://firebasestorage.googleapis.com/v0/b/sessions-e4256.appspot.com/o/app_files%2Fexpanded.png?alt=media&token=1fc46cd0-58a6-4fbc-93db-2c73dcb53b21";
String tableeImage = "https://firebasestorage.googleapis.com/v0/b/sessions-e4256.appspot.com/o/app_files%2Ftable.png?alt=media&token=cadafeb4-b52e-4d1a-bdda-4cb1599f00fa";
String dailyImage = "https://firebasestorage.googleapis.com/v0/b/sessions-e4256.appspot.com/o/app_files%2Fdaily.jpg?alt=media&token=f5500ab8-03e7-4fe2-a5d6-6fc30b423fd6";
String monthlyImage = "https://firebasestorage.googleapis.com/v0/b/sessions-e4256.appspot.com/o/app_files%2Fmonthly.jpg?alt=media&token=880d6e45-e567-40e4-9700-ac8872f40fce";
String weeklyImage = "https://firebasestorage.googleapis.com/v0/b/sessions-e4256.appspot.com/o/app_files%2Fweekly.jpg?alt=media&token=2b28cb83-fed5-4d9a-a207-b6b651bf7317";
String profileImage = "https://firebasestorage.googleapis.com/v0/b/sessions-e4256.appspot.com/o/app_files%2Fprofile.jpg?alt=media&token=241d6114-550c-4198-9d3a-15513a22dfbf";
String imageWeekEmpty = "https://firebasestorage.googleapis.com/v0/b/sessions-e4256.appspot.com/o/app_files%2Femptyweek.gif?alt=media&token=ffa3e0dd-3639-47e6-ac9c-9e47d0bc072a";

bool kttoGlobal = true;
bool kgtoGlobal = true;

class Gfs
{
  // void logData(var tableId, var message ){
  //   try{
  //     List now = DateTime.now().toString().split(' ');
  //     String date  = "${now[0]}   ${now[1].toString().substring(0, 5)}";
  //     String logId = "${now[0]} ${now[1].toString().substring(0, 5)}".replaceAll(new RegExp(r"[^\s\w]"), '')
  //         .replaceAll(new RegExp(r" "), '') + '_${nanoid(3)}'.replaceAll(new RegExp(r"[^\s\w]"), '');
  //
  //     print(' Logged :: $date-$message');
  //
  //     db.child('tables/$tableId/logs').update({
  //       logId : '$date@$message'
  //     });
  //   }
  //   catch(e){
  //     print('Error Logging Data!  :: ' + e.toString());
  //   }
  // }

  List getDays(day) {
    String weekDay = DateFormat('EEEE').format(DateTime.parse(day));
    DateTime date = DateTime.parse(day);
    if(weekDay=='Sunday'){
      List<String> days = [day, date.add(const Duration(days: 1)).toString().split(' ')[0], date.add(const Duration(days: 2)).toString().split(' ')[0],
        date.add(const Duration(days: 3)).toString().split(' ')[0],date.add(const Duration(days: 4)).toString().split(' ')[0],
        date.add(const Duration(days: 5)).toString().split(' ')[0],date.add(const Duration(days: 6)).toString().split(' ')[0],];
      return days;
    }
    else if(weekDay=='Monday'){
      List<String> days = [date.subtract(const Duration(days: 1)).toString().split(' ')[0], day, date.add(const Duration(days: 1)).toString().split(' ')[0],
        date.add(const Duration(days: 2)).toString().split(' ')[0],date.add(const Duration(days: 3)).toString().split(' ')[0],
        date.add(const Duration(days: 4)).toString().split(' ')[0],date.add(const Duration(days: 5)).toString().split(' ')[0],];
      return days;
    }
    else if(weekDay=='Tuesday'){
      List<String> days = [date.subtract(const Duration(days: 2)).toString().split(' ')[0], date.subtract(const Duration(days: 1)).toString().split(' ')[0],
        day, date.add(const Duration(days: 1)).toString().split(' ')[0],date.add(const Duration(days: 2)).toString().split(' ')[0],
        date.add(const Duration(days: 3)).toString().split(' ')[0],date.add(const Duration(days: 4)).toString().split(' ')[0],];
      return days;
    }
    else if(weekDay=='Wednesday'){
      List<String> days = [date.subtract(const Duration(days: 3)).toString().split(' ')[0], date.subtract(const Duration(days: 2)).toString().split(' ')[0],
        date.subtract(const Duration(days: 1)).toString().split(' ')[0], day, date.add(const Duration(days: 1)).toString().split(' ')[0],
        date.add(const Duration(days: 2)).toString().split(' ')[0],date.add(const Duration(days: 3)).toString().split(' ')[0],];
      return days;
    }
    else if(weekDay=='Thursday'){
      List<String> days = [date.subtract(const Duration(days: 4)).toString().split(' ')[0], date.subtract(const Duration(days: 3)).toString().split(' ')[0],
        date.subtract(const Duration(days: 2)).toString().split(' ')[0], date.subtract(const Duration(days: 1)).toString().split(' ')[0], day,
        date.add(const Duration(days: 1)).toString().split(' ')[0],date.add(const Duration(days: 2)).toString().split(' ')[0],];
      return days;
    }
    else if(weekDay=='Friday'){
      List<String> days = [date.subtract(const Duration(days: 5)).toString().split(' ')[0], date.subtract(const Duration(days: 4)).toString().split(' ')[0],
        date.subtract(const Duration(days: 3)).toString().split(' ')[0], date.subtract(const Duration(days: 2)).toString().split(' ')[0],
        date.subtract(const Duration(days: 1)).toString().split(' ')[0], day, date.add(const Duration(days: 1)).toString().split(' ')[0],];
      return days;
    }
    else if(weekDay=='Saturday'){
      List<String> days = [date.subtract(const Duration(days: 6)).toString().split(' ')[0], date.subtract(const Duration(days: 5)).toString().split(' ')[0],
        date.subtract(const Duration(days: 4)).toString().split(' ')[0], date.subtract(const Duration(days: 3)).toString().split(' ')[0],
        date.subtract(const Duration(days: 2)).toString().split(' ')[0], date.subtract(const Duration(days: 1)).toString().split(' ')[0], day];
      return days;
    }
    else{
      List<String> days = [date.subtract(const Duration(days: 6)).toString().split(' ')[0], date.subtract(const Duration(days: 5)).toString().split(' ')[0],
        date.subtract(const Duration(days: 4)).toString().split(' ')[0], date.subtract(const Duration(days: 3)).toString().split(' ')[0],
        date.subtract(const Duration(days: 2)).toString().split(' ')[0], date.subtract(const Duration(days: 1)).toString().split(' ')[0], day];
      return days;
    }
  }
}
