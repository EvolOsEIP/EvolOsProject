import 'inbox/inbox.dart';
import 'newMail/new_mail.dart';
import 'spam/spam.dart';
import 'profile/profile.dart';
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
  final Inbox _inboxInstance = Inbox();
  final NewMail _newMailInstance = NewMail();
  final Spam _spamInstance = Spam();
  final Profile _profileInstance = Profile();

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
    switch (_selectedItem) {
      case "Inbox":
        _inboxInstance.start_tuto(context);
        break;
      case "New Mail":
        _newMailInstance.start_tuto(context);
        break;
      case "Spam":
        _spamInstance.start_tuto(context);
        break;
      case "Profile":
        _profileInstance.start_tuto(context);
        break;
      default:
        break;
    }
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
