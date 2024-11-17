import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:enough_mail/enough_mail.dart';

class Spam extends StatefulWidget {
  const Spam({super.key});

  @override
  _SpamState createState() => _SpamState();
}

class _SpamState extends State<Spam> {
  late final String _email;
  late final String _appPassword;
  List<String> emailSubjects = [];
  List<String> emailPreviews = [];

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await dotenv.load(fileName: ".env");
    _email = dotenv.env['GMAIL_USERNAME']!;
    _appPassword = dotenv.env['GMAIL_APP_PASSWORD']!;

    await _fetchEmails();
  }

  Future<void> _fetchEmails() async {
    try {
      // Connect to Gmail via IMAP using the App Password
      final imapServer = 'imap.gmail.com';
      final imapPort = 993; // Port for SSL/TLS connection

      final imapClient = ImapClient(isLogEnabled: true);
      // Open connection and fetch messages from Spam
      await imapClient.connectToServer(imapServer, imapPort, isSecure: true);
      await imapClient.login(_email, _appPassword);

      // Select the Spam folder
      List<Mailbox> mailbox = await imapClient.listMailboxes(path: "[Gmail]/");

      for (Mailbox box in mailbox) {
        print("Looking for spam folder");
        print(box.name);
        if (box.name == "Spam") {
          print("Found spam folder");
          await imapClient.selectMailbox(box);
          final messages = await imapClient.fetchRecentMessages(
            messageCount: 10,
            criteria: 'ALL',
          );

          // call select() first
          // Fetch the email subjects and previews
          final FetchImapResult result = await imapClient.fetchRecentMessages(
            messageCount: 10,
            criteria: "ALL",
          );

          setState(() {
            print("Fetched messages");
            for (final message in result.messages) {
              final subject = message.envelope?.subject;
              final preview = message.body?.toString();
              emailSubjects.add(subject ?? 'No Subject');
              emailPreviews.add(preview ?? 'No Preview');
            }
          });
          break;
        }
      }

      // Close the connection
      await imapClient.logout();
    } catch (e) {
      print("Error fetching emails: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
        ),
        Expanded(
          child: Container(
            color: Color(0xFF7FD1B9),
            child: ListView.builder(
              itemCount: emailSubjects.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(emailSubjects[index]),
                  subtitle: Text(emailPreviews[index]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
