import 'inbox.dart';
import 'new_mail.dart';
import 'spam.dart';
import 'profile.dart';
import 'mail_service.dart';
import 'package:flutter/material.dart';

class MailManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mail Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MailManagerHome(),
    );
  }
}

class MailManagerHome extends StatefulWidget {
  @override
  _MailManagerState createState() => _MailManagerState();
}

class _MailManagerState extends State<MailManagerHome> {
  /* Side bar code */
  String _selectedItem = "New Mail"; //default page display
  String? _hoveredItem;
  Widget _buildSidebarItem(String title) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredItem = title),
      onExit: (_) => setState(() => _hoveredItem = null),
      child: Container(
        color: _hoveredItem == title ? Color(0xFFB09E8A) : Colors.transparent,
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          onTap: () => setState(() => _selectedItem = title),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Divider(thickness: 1.0, color: Colors.black),
    );
  }

  /* Page content code */
  Widget _buildMainContent() {
    switch (_selectedItem) {
      case "Inbox":
        return Inbox();
      case "New Mail":
        return NewMail();
      case "Spam":
        return Spam();
      case "Profile":
        return Profile();
      default:
        return Container();
    }
  }

  void _startTutorial() {
    String message;
    switch (_selectedItem) {
      case "Inbox":
        message = "Tutorial for Inbox coming soon!";
        break;
      case "New Mail":
        message = "Tutorial for New Mail coming soon!";
        break;
      case "Spam":
        message = "Tutorial for Spam coming soon!";
        break;
      case "Profile":
        message = "Tutorial for Profile coming soon!";
        break;
      default:
        message = "";
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A8577),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: const Text(
                'MAIL',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: ElevatedButton(
                onPressed: _startTutorial,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Start Tuto",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Container(
            // Sidebar
            width: 200,
            color: Color(0xFFCCB0A3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSidebarItem("Inbox"),
                _buildDivider(),
                _buildSidebarItem("New Mail"),
                _buildDivider(),
                _buildSidebarItem("Spam"),
                _buildDivider(),
                _buildSidebarItem("Profile"),
                _buildDivider(),
              ],
            ),
          ),
          Expanded(child: _buildMainContent()),
        ],
      ),
    );
  }
}
