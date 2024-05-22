import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  List<Map<String, String>> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotificationData();
  }

  Future<void> _loadNotificationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? existingNotifications = prefs.getString('notifications');
    setState(() {
      if (existingNotifications != null) {
        List<dynamic> decodedNotifications = json.decode(existingNotifications);
        _notifications = decodedNotifications.map((notification) {
          return Map<String, String>.from(notification);
        }).toList();
      } else {
        _notifications = [];
      }
    });
    print('Loaded notifications: $_notifications');
  }

  Future<void> _clearNotificationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('notifications');
    setState(() {
      _notifications = [];
    });
    print('Cleared notifications');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: _clearNotificationData,
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? Center(child: Text('No notifications available'))
          : ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Text(
                notification['title'] ?? 'No Title',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5.0),
                  Text(
                    notification['body'] ?? 'No Body',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    'Received: ${notification['sentTime'] ?? 'Unknown time'}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
