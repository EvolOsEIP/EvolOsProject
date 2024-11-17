import 'package:flutter/material.dart';

import 'prompt.dart';
import 'mainPages/page_manager.dart';

void main() {
  runApp(MailManagerApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prompt Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PromptPage(),
    );
  }
}
