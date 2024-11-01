import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email Sender',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EmailSenderScreen(),
    );
  }
}

class EmailSenderScreen extends StatefulWidget {
  const EmailSenderScreen({Key? key}) : super(key: key);

  @override
  _EmailSenderScreenState createState() => _EmailSenderScreenState();
}

class _EmailSenderScreenState extends State<EmailSenderScreen> {
  final TextEditingController _senderController = TextEditingController();
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _senderController,
              decoration: const InputDecoration(
                labelText: 'Sender Email (e.g., test@localhost)',
              ),
            ),
            TextField(
              controller: _recipientController,
              decoration: const InputDecoration(
                labelText: 'Recipient Email (e.g., recipient@localhost)',
              ),
            ),
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(
                labelText: 'Subject',
              ),
            ),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(
                labelText: 'Body',
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendEmail,
              child: const Text('Send Email'),
            ),
          ],
        ),
      ),
    );
  }
}
