import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MailManagerApp());
}

class MailManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mail Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MailManagerHome(),
    );
  }
}

class MailManagerHome extends StatefulWidget {
  @override
  _MailManagerHomeState createState() => _MailManagerHomeState();
}

class _MailManagerHomeState extends State<MailManagerHome> {
  final TextEditingController _senderController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  String? _hoveredItem;

  Future<void> _sendEmail() async {
    final String sender = _senderController.text.trim();
    final String recipient = _recipientController.text.trim();
    final String subject = _subjectController.text.trim();
    final String body = _bodyController.text.trim();

    final Map<String, dynamic> emailData = {
      'sender': sender,
      'recipient': recipient,
      'subject': subject,
      'body': body,
    };

    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/send-email'), // Flask server URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(emailData),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email sent successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.body}')),
      );
    }
}

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
        onTap: () {
          // Action au clic sur l'élément
        },
      ),
    ),
  );
}

Widget _buildDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Divider(
      thickness: 1.0,
      color: Colors.black,
    ),
  );
}

@override
Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mail Manager"),
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
          // Main Content
          Expanded(
            child: Column(
              children: [
                // Mail List
                Expanded(
                  child: Container(
                    color: Color(0xFF7FD1B9),
                    child: ListView.builder(
                      itemCount: 10, // Placeholder for emails
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("Mail Subject $index"),
                          subtitle: Text("Preview of the mail content."),
                          onTap: () {
                            // Add logic to display email
                          },
                        );
                      },
                    ),
                  ),
                ),
                // Mail Composer
                Container(
                  color: Color(0xFFF6AE2D),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        controller: _recipientController,
                        decoration: InputDecoration(
                          labelText: "To",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _subjectController,
                        decoration: InputDecoration(
                          labelText: "Subject",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _bodyController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: "Compose email...",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _sendEmail,
                        child: Text("Send"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF227C9D),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
