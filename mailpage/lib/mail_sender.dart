import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MailSender {
  String email = "";
  String username = "";
  String password = "";
  String receiver = "";
  String? subject;
  String? mailContent;
  List<dynamic> copyReceiver = [];
  List<dynamic> blindCopyReceiver = [];
  final message = Message();
  late final SmtpServer smtpServer;

  void setSmtpServer(String email, String password) {
    smtpServer = gmail(email, password);
  }

  void SetMailData(
      String email, String username, String password, String receiver,
      [String? subject, String? mailContent]) {
    // List<dynamic> copyReceiver,
    // List<dynamic> blindCopyReceiver]) {
    this.email = email;
    this.username = username;
    this.password = password;
    this.receiver = receiver;
    // this.copyReceiver = copyReceiver;
    // this.blindCopyReceiver = blindCopyReceiver;
    this.mailContent = mailContent;
  }

  void sendEmail() async {
    print(email);
    print(username);
    print(password);
    message
      ..from = Address(email, username)
      ..recipients.add(Address(receiver))
      // ..ccRecipients.addAll(copyReceiver)
      // ..bccRecipients.add(blindCopyReceiver)
      ..subject = subject
      ..text = mailContent;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
    // var connection = PersistentConnection(smtpServer);
//
    // await connection.send(message);
//
    // await connection.close();
  }
}
