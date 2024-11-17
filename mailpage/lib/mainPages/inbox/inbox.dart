import 'package:flutter/material.dart';

class Inbox extends StatelessWidget {

  void start_tuto(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Inbox Tutorial'),
          content: Text('This is the tutorial for the Inbox section.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
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
  }
}
