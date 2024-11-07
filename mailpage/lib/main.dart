import 'package:flutter/material.dart';
import 'mail_service.dart';
import 'inbox.dart';
import 'new_mail.dart';
import 'spam.dart';
import 'profile.dart';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void sendMail () async {
  String username = 'sebEvolOs@gmail.com';
  String password = 'password';

  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.

  // Create our message.
  final message = Message()
    ..from = Address(username, 'Seb EvolOs')
    ..recipients.add('sebastien.nourry@epitech.eu')
    ..ccRecipients
        .addAll(['appoline.fontaine@epitech.eu', 'clement.lagier@epitech.eu'])
    //..bccRecipients.add(Address('clement.lagier@epitech.eu'))
    ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
  // DONE

  // Let's send another message using a slightly different syntax:
  //
  // Addresses without a name part can be set directly.
  // For instance `..recipients.add('destination@example.com')`
  // If you want to display a name part you have to create an
  // Address object: `new Address('destination@example.com', 'Display name part')`
  // Creating and adding an Address object without a name part
  // `new Address('destination@example.com')` is equivalent to
  // adding the mail address as `String`.
  final equivalentMessage = Message()
    ..from = Address(username, 'Your name 😀')
    ..recipients.add(Address('destination@example.com'))
    ..ccRecipients
        .addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
    ..bccRecipients.add('bccAddress@example.com')
    ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html =
        '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p><img src="cid:myimg@3.141"/>'
    ..attachments = [
      FileAttachment(File('exploits_of_a_mom.png'))
        ..location = Location.inline
        ..cid = '<myimg@3.141>'
    ];

  final sendReport2 = await send(equivalentMessage, smtpServer);

  // Sending multiple messages with the same connection
  //
  // Create a smtp client that will persist the connection
  var connection = PersistentConnection(smtpServer);

  // Send the first message
  await connection.send(message);

  // send the equivalent message
  await connection.send(equivalentMessage);

  // close the connection
  await connection.close();
}

void main() {
  sendEmail();
  runApp(MailManagerApp());
}

class MailManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mail Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MailManagerHome(),
    );
  }
}

class MailManagerHome extends StatefulWidget {
  @override
  _MailManagerState createState() => _MailManagerState();
}

class _MailManagerState extends State<MailManagerHome> {

  /* Side bar code */
  String _selectedItem = "New Mail"; //default page display
  String? _hoveredItem;
  Widget _buildSidebarItem(String title) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredItem = title),
      onExit: (_) => setState(() => _hoveredItem = null),
      child: Container(
        color: _hoveredItem == title ? Color(0xFFB09E8A) : Colors.transparent,
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          onTap: () => setState(() => _selectedItem = title),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(thickness: 1.0, color: Colors.black),
    );
  }

  /* Page content code */
  Widget _buildMainContent() {
    switch (_selectedItem) {
      case "Inbox":
        return Inbox();
      case "New Mail":
        return NewMail();
      case "Spam":
        return Spam();
      case "Profile":
        return Profile();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mail'),
        backgroundColor: const Color(0xFF4A8577),
      ),
      body: Row(
        children: [
          Container( // Sidebar
            width: 200,
            color: Color(0xFFCCB0A3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSidebarItem("Inbox"),
                _buildDivider(),
                _buildSidebarItem("New Mail"),
                _buildDivider(),
                _buildSidebarItem("Spam"),
                _buildDivider(),
                _buildSidebarItem("Profile"),
                _buildDivider(),
              ],
            ),
          ),
          Expanded(child: _buildMainContent()),
        ],
      ),
    );
  }

}
