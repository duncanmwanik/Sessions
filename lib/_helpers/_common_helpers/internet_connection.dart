import 'dart:async';
// import 'dart:io';

// import 'package:http/http.dart' as http;
// import 'package:sessions/_helpers/_common_helpers/global_helper.dart';

// import '../../_widgets/components/toast.dart';

Future<bool> hasAccessToInternet() async {
  // try {
  //   final url = Uri.https('google.com');

  //   var response = await http.get(url).timeout(Duration(seconds: 10));

  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     errorPrint('internet-checker', 'Bad internet connection');
  //     return false;
  //   }
  // } on TimeoutException catch (_) {
  //   errorPrint('internet-checker', 'Slow internet connection.');
  //   return false;
  // } on SocketException catch (_) {
  //   showToast(0, 'Check your internet connection.');
  //   errorPrint('internet-checker', 'Check internet connection.');

  //   return false;
  // } catch (e) {
  //   errorPrint('internet-checker', e);
  //   showToast(0, 'No internet connection.');
  //   errorPrint('internet-checker', 'No internet connection.');
  //   print(e);

  //   return false;
  // }

  return true;
}
