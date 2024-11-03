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
  final TextEditingController _ccController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _signatureController = TextEditingController();

  bool _isBold = false;
  bool _isItalic = false;
  bool _isUnderlined = false;

  void _toggleBold() => setState(() => _isBold = !_isBold);
  void _toggleItalic() => setState(() => _isItalic = !_isItalic);
  void _toggleUnderline() => setState(() => _isUnderlined = !_isUnderlined);

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
    _ccController.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // field recipient
            Row(
              children: [
                // Champ "To"
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("To: ", style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w400)),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 430,
                          height: 45,
                          child: _buildTextField(_recipientController, "The mail recipient", hintText: "ex: nameof.therecipient@mail.com"),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                // Champ "Cc"
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text("Cc: ", style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w400)),
                        const SizedBox(width: 5),
                        SizedBox(
                          width: 430,
                          height: 45,
                          child: _buildTextField(_ccController, "The recipient who receives a copy",  hintText: "ex: nameof.copypersonn@mail.com"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Champ Subject
            _buildTextField(_subjectController, "Subject"),
            const SizedBox(height: 10),

            // Zone de rédaction et barre d'outils
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Zone de rédaction
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Expanded(child: _buildTextField(_bodyController, "Compose email...", maxLines: 10)),
                        const SizedBox(height: 10),
                        _buildTextField(_signatureController, "Signature", maxLines: 2),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  _buildToolbar(),
                ],
              ),
            ),

            // Boutons en bas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Attach file feature coming soon!')),
                    );
                  },
                  icon: const Icon(Icons.attach_file),
                  label: const Text("Pièce jointe"),
                ),
                ElevatedButton(
                  onPressed: _sendEmail,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4A8577)),
                  child: const Text("Send", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbar() {
    return Container(
      width: 50,
      color: const Color(0xFFEDEDED),
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          IconButton(
            icon: Icon(Icons.format_bold, color: _isBold ? Colors.black : Colors.grey),
            onPressed: _toggleBold,
            tooltip: 'Bold',
          ),
          IconButton(
            icon: Icon(Icons.format_italic, color: _isItalic ? Colors.black : Colors.grey),
            onPressed: _toggleItalic,
            tooltip: 'Italic',
          ),
          IconButton(
            icon: Icon(Icons.format_underline, color: _isUnderlined ? Colors.black : Colors.grey),
            onPressed: _toggleUnderline,
            tooltip: 'Underline',
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1, String? hintText}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label.isEmpty ? null : label,
        hintText: hintText,
        hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        border: OutlineInputBorder(),
      ),
      style: TextStyle(
        fontWeight: _isBold ? FontWeight.bold : FontWeight.normal,
        fontStyle: _isItalic ? FontStyle.italic : FontStyle.normal,
        decoration: _isUnderlined ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}
