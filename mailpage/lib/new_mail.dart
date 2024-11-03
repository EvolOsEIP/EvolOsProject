import 'package:flutter/material.dart';
import 'mail_service.dart';

class NewMail extends StatefulWidget {
  NewMail({Key? key}) : super(key: key);

  @override
  _NewMailState createState() => _NewMailState();
}

class _NewMailState extends State<NewMail> {
  final EmailService _emailService = EmailService();
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  Future<void> _sendEmail() async {
    final result = await _emailService.sendEmail(
      recipient: _recipientController.text,
      subject: _subjectController.text,
      body: _bodyController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Selected: New Mail",
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
}
