import 'package:flutter/material.dart';
import 'mail_service.dart';
import 'mail_sender.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NewMail extends StatefulWidget {
  NewMail({Key? key}) : super(key: key);

  void start_tuto(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New Mail Tutorial'),
          content: Text('This is the tutorial for the written section.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("I'm ready to start !"),
            ),
          ],
        );
      },
    );
  }

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

  Map<String, dynamic> textStyles = {
    "isBold": false,
    "isItalic": false,
    "isUnderlined": false,
    "isHighlighted": false,
    "textColor": Colors.black,
  };

  final List<Color> _colorPalette = [Colors.black, Colors.red, Colors.blue, Colors.green, Colors.orange, Colors.purple, Colors.brown, Colors.grey];

  void _toggleBold() => setState(() => textStyles["isBold"] = !textStyles["isBold"]);
  void _toggleItalic() => setState(() => textStyles["isItalic"] = !textStyles["isItalic"]);
  void _toggleUnderline() => setState(() => textStyles["isUnderlined"] = !textStyles["isUnderlined"]);
  void _toggleHighlight() => setState(() => textStyles["isHighlighted"] = !textStyles["isHighlighted"]);
  void _changeTextColor(Color color) => setState(() => textStyles["textColor"] = color);

  Future<void> _sendEmail() async {
    await dotenv.load();
    MailSender mailSender = MailSender();
    mailSender.setSmtpServer(dotenv.env['GMAIL_USERMAIL'].toString(),
        dotenv.env['GMAIL_PASSWORD'].toString());
    mailSender.SetMailData(
      dotenv.env['GMAIL_USERMAIL'].toString(),
      'Seb EvolOs',
      dotenv.env['GMAIL_PASSWORD'].toString(),
      _recipientController.text,
    );
    mailSender.subject = _subjectController.text;
    mailSender.mailContent = _bodyController.text;
    mailSender.sendEmail();
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
            Row(
              children: [
                // Champ "To"
                Expanded(
                  child: Row(
                    children: [
                      const Text("To: ",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                      const SizedBox(width: 5),
                      Expanded(
                        child: _buildTextField(_recipientController, "The mail recipient", hintText: "ex: nameof.therecipient@mail.com"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // Champ "Cc"
                Expanded(
                  child: Row(
                    children: [
                      const Text("Cc: ",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w400)),
                      const SizedBox(width: 5),
                      Expanded(
                          child: _buildTextField(_ccController, "The recipient who receives a copy", hintText: "ex: nameof.copypersonn@mail.com")),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Field Subject
            Row(
              children: [
                const Text("Re: ",
                    style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.w400)),
                const SizedBox(width: 5),
                Expanded(child: _buildTextField(_subjectController, "The main topic of your mail, as a title", hintText: "ex: About the tomorrow's event")),
              ],
            ),
            const SizedBox(height: 10),

            // Zone de rédaction et barre d'outils
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Expanded(child: _buildTextField(_bodyController, "Email body", maxLines: 15, hintText: "Type your email content here.\nEx: Dear X, I would like to ...")),
                        const SizedBox(height: 10),
                        _buildTextField(_signatureController, "Signature", maxLines: 3, hintText: "e.g., John Doe\nCEO, Company Name")
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  _buildToolbar(),
                ],
              ),
            ),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Attach file feature coming soon!')),
                    );
                  },
                  icon: const Icon(Icons.attach_file),
                  label: const Text("Attachment"),
                ),
                ElevatedButton(
                  onPressed: _sendEmail,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A8577)),
                  child:
                      const Text("Send", style: TextStyle(color: Colors.white)),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              Icons.format_bold,
              color: textStyles["isBold"] ? Colors.black : Colors.grey,
            ),
            onPressed: _toggleBold,
            tooltip: 'Bold',
          ),
          IconButton(
            icon: Icon(
              Icons.format_italic,
              color: textStyles["isItalic"] ? Colors.black : Colors.grey,
            ),
            onPressed: _toggleItalic,
            tooltip: 'Italic',
          ),
          IconButton(
            icon: Icon(
              Icons.format_underline,
              color: textStyles["isUnderlined"] ? Colors.black : Colors.grey,
            ),
            onPressed: _toggleUnderline,
            tooltip: 'Underline',
          ),
          PopupMenuButton<Color>(
            icon: Icon(Icons.color_lens, color: textStyles["textColor"]),
            onSelected: _changeTextColor,
            itemBuilder: (BuildContext context) {
              return _colorPalette.map((Color color) {
                return PopupMenuItem<Color>(
                  value: color,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 0.5)),
                  ),
                );
              }).toList();
            },
            tooltip: 'Color',
          ),
          IconButton(
            icon: Icon(
              Icons.highlight,
              color: textStyles["isHighlighted"] ? Colors.yellow : Colors.grey,
            ),
            onPressed: _toggleHighlight,
            tooltip: 'Highlight',
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
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.all(10),
      ),
      style: TextStyle(
        fontWeight: textStyles["isBold"] ? FontWeight.bold : FontWeight.normal,
        fontStyle: textStyles["isItalic"] ? FontStyle.italic : FontStyle.normal,
        decoration: textStyles["isUnderlined"] ? TextDecoration.underline : TextDecoration.none,
        color: textStyles["textColor"],
      ),
    );
  }
}
