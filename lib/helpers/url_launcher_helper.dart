import 'package:url_launcher/url_launcher.dart';

Future<void> sendUserFeedbackViaEmail() async {
  String email = Uri.encodeComponent("hey@sessions.com");
  String subject = Uri.encodeComponent("Feedback");
  String body = Uri.encodeComponent("Hello...");
  Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
  if (await launchUrl(mail)) {
    //email app opened
  } else {
    //email app is not opened
  }
}
