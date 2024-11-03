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
      theme: ThemeData(primarySwatch: Colors.blue),
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
  String _selectedItem = "Inbox";

  Future<void> _sendEmail() async {
    final emailData = {
      'sender': _senderController.text.trim(),
      'recipient': _recipientController.text.trim(),
      'subject': _subjectController.text.trim(),
      'body': _bodyController.text.trim(),
    };

    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/send-email'),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: json.encode(emailData),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.statusCode == 200
            ? 'Email sent successfully!'
            : 'Error: ${response.body}'),
      ),
    );
  }

  Widget _buildSidebarItem(String title) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredItem = title),
      onExit: (_) => setState(() => _hoveredItem = null),
      child: Container(
        color: _hoveredItem == title ? Color(0xFFB09E8A) : Colors.transparent,
        child: ListTile(
          title: Text( title,
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

  Widget _buildMainContent() {
    switch (_selectedItem) {
      case "Inbox":
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Selected: $_selectedItem",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
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
          ],
        );
      case "New Mail":
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Selected: $_selectedItem",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                color: Color(0xFF7FD1B9),
                child: _buildEmailComposer(),
              ),
            ),
          ],
        );
      case "Spam":
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Selected: $_selectedItem",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        );
      case "Profile":
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Selected: $_selectedItem",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        );
      default:
        return Container();
    }
  }

  Widget _buildEmailComposer() {
    return Container(
      color: Color(0xFFF6AE2D),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          _buildTextField(_recipientController, "To"),
          SizedBox(height: 10),
          _buildTextField(_subjectController, "Subject"),
          SizedBox(height: 10),
          _buildTextField(_bodyController, "Compose email...", maxLines: 5),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: _sendEmail,
            child: Text("Send"),
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF227C9D)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(labelText: label, border: OutlineInputBorder()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mail Manager")),
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
          Expanded(child: _buildMainContent()),
        ],
      ),
    );
  }
}
