import 'package:url_launcher/url_launcher.dart' as UL;

class EmailSendClass {
  static Future<void> sendEmail({
    required String email,
    required String subject,
    required String body,
  }) async {
    String mail = "mailto:$email?subject=$subject&body=${Uri.encodeFull(body)}";
    if (await UL.canLaunch(mail)) {
      await UL.launch(mail);
    } else {
      throw Exception("Unable to open the email");
    }
  }
}
