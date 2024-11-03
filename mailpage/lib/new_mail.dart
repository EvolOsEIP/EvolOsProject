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

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
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
    return Container(
      color: const Color(0xFFF5F3EE),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            _buildTextField(_recipientController, "To"),
            const SizedBox(height: 10),
            _buildTextField(_subjectController, "Subject"),
            const SizedBox(height: 10),
            _buildTextField(_bodyController, "Compose email...", maxLines: 5),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _sendEmail,
              child: const Text("Send"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF227C9D),
              ),
            ),
          ],
        ),
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
