import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserHelpMonitor extends StatefulWidget {
  @override
  _UserHelpMonitorState createState() => _UserHelpMonitorState();
}

class _UserHelpMonitorState extends State<UserHelpMonitor> {
  int backspaceCount = 0;
  Timer? inactivityTimer;
  Offset? lastMousePosition;

  void _handleKeyPress(RawKeyEvent event) {
    final key = event.logicalKey.debugName;

    if (key == "Backspace") {
      backspaceCount++;
      if (backspaceCount > 5) {
        _showHelpPrompt("It seems you're having trouble typing. Need help?");
        backspaceCount = 0;
      }
    } else {
      backspaceCount = 0; // Reset counter on other key presses
    }
  }

  void _monitorMouseActivity(PointerEvent event) {
    final currentMousePosition = event.position;
    if (lastMousePosition != null &&
        (currentMousePosition - lastMousePosition!).distance > 50) {
      // Example: Trigger help if mouse movement is erratic
      _showHelpPrompt("Having trouble navigating? Let us help!");
    }
    lastMousePosition = currentMousePosition;
  }

  void _resetInactivityTimer() {
    inactivityTimer?.cancel();
    inactivityTimer = Timer(Duration(seconds: 10), () {
      _showHelpPrompt("You've been inactive for a while. Need assistance?");
    });
  }

  void _showHelpPrompt(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Need Help?"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Dismiss"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    RawKeyboard.instance.addListener(_handleKeyPress);
  }

  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_handleKeyPress);
    inactivityTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Help Monitor')),
      body: Listener(
        onPointerMove: (event) {
          _monitorMouseActivity(event);
          _resetInactivityTimer();
        },
        child: Center(
          child: Text('Interact with the app to monitor input.'),
        ),
      ),
    );
  }
}
