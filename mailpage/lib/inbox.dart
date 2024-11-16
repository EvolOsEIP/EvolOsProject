import 'package:flutter/material.dart';

class Inbox extends StatelessWidget {
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
