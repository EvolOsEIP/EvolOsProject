import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:enough_mail/enough_mail.dart';

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
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

    _fetchEmails();
  }

  Future<void> _fetchEmails() async {
    try {
      // Connect to Gmail via IMAP using the App Password
      final imapServer = 'imap.gmail.com';
      final imapPort = 993; // Port for SSL/TLS connection

      final imapClient = ImapClient(isLogEnabled: true);
      // Open connection and fetch messages from inbox
      await imapClient.connectToServer(imapServer, imapPort, isSecure: true);
      await imapClient.login(_email, _appPassword);

      // call select() first
      await imapClient.selectInbox();

      // Fetch the first 10 messages
      final FetchImapResult result = await imapClient.fetchRecentMessages(
          messageCount: 10, criteria: "ALL");

      // FetchImapResult used in the for loop must implement the Iterable<dynamic> interface

      // loop to count to 19
      // Process fetched messages
      for (final message in result.messages) {
        final subject = message.envelope?.subject;
        final preview = message.body?.toString();
        emailSubjects.add(subject ?? 'No Subject');
        emailPreviews.add(preview ?? 'No Preview');
      }
      displayMails();
      // Close the connection
      await imapClient.logout();
    } catch (e) {
      print("Error fetching emails: $e");
    }
  }

  void displayMails() {
    setState(() {});

    // display the email subjects and previews on the ap
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Selected: Inbox",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
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
                  onTap: () {
                    // Handle onTap action, e.g., open the email
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
