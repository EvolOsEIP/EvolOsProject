import 'package:flutter/material.dart';
import 'mainPages/page_manager.dart';

class PromptPage extends StatefulWidget {
  @override
  _PromptPageState createState() => _PromptPageState();
}

class _PromptPageState extends State<PromptPage> {
  final TextEditingController _controller = TextEditingController();

  void _handlePrompt() {
    if (_controller.text.toLowerCase().contains('send an email')) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MailManagerApp()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Prompt not recognized.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prompt Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter your prompt',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _handlePrompt,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class MailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mail Page'),
      ),
      body: Center(
        child: Text('This is the mail sending page.'),
      ),
    );
  }
}
