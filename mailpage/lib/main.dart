import 'package:flutter/material.dart';
import 'mail_service.dart';
import 'inbox.dart';
import 'new_mail.dart';
import 'spam.dart';
import 'profile.dart';

void main() {
  runApp(MailManagerApp());
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mail Manager")),
      body: Row(
        children: [
          Container( // Sidebar
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
