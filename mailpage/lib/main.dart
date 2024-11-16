import 'package:flutter/material.dart';

import 'prompt.dart';

void main() {
  runApp(MyApp());
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
