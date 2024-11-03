import 'package:flutter/material.dart';
import 'mail_service.dart';

class NewMail extends StatefulWidget {
  final TextEditingController recipientController;
  final TextEditingController subjectController;
  final TextEditingController bodyController;

  NewMail({
    required this.recipientController,
    required this.subjectController,
    required this.bodyController,
  });

  @override
  _NewMailState createState() => _NewMailState();
}

class _NewMailState extends State<NewMail> {
  final EmailService _emailService = EmailService();

  Future<void> _sendEmail() async {
    final result = await _emailService.sendEmail(
      recipient: widget.recipientController.text,
      subject: widget.subjectController.text,
      body: widget.bodyController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );
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
          _buildTextField(widget.recipientController, "To"),
          SizedBox(height: 10),
          _buildTextField(widget.subjectController, "Subject"),
          SizedBox(height: 10),
          _buildTextField(widget.bodyController, "Compose email...", maxLines: 5),
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
