import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:license/res/colors.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../res/textstyle.dart';


class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotificationData();
  }

  Future<void> _loadNotificationData() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      QuerySnapshot querySnapshot = await _firestore
          .collection('students')
          .doc(userId)
          .collection('notifications')
          .orderBy('sentTime', descending: true)
          .get();

      List<Map<String, dynamic>> notifications = querySnapshot.docs.map((doc) {
        return {
          'title': doc['title'],
          'body': doc['body'],
          'sentTime': doc['sentTime'],
          'photoUrl': doc['photoUrl'],
        };
      }).toList();

      setState(() {
        _notifications = notifications;
      });
    }
  }

  Future<void> _clearNotificationData() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      WriteBatch batch = _firestore.batch();
      var snapshots = await _firestore
          .collection('students')
          .doc(userId)
          .collection('notifications')
          .get();
      for (var doc in snapshots.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }

    setState(() {
      _notifications = [];
    });
    print('Cleared notifications');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: AppTextStyles.headline),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: _clearNotificationData,
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Our all Notifications',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          Expanded(
            child: _notifications.isEmpty
                ? Center(child: Text('No notifications available'))
                : ListView.builder(
                  padding: EdgeInsets.all(16.0),
                  itemCount: _notifications.length,
                  itemBuilder: (context, index) {
                    final notification = _notifications[index];

                  final DateTime sentTime = DateTime.parse(notification['sentTime']);
                  final String timeAgo = timeago.format(sentTime, locale: 'en_short');
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      color: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    leading: notification['photoUrl'] != null && notification['photoUrl'].isNotEmpty
                        ? Image.network(
                      notification['photoUrl'],
                      width: 40,
                      height: 40,
                    )
                        : Image.asset(
                      'assets/images/exams.png',
                      width: 40,
                      height: 40,
                    ),
                    title: Text(
                      notification['title'] ?? 'No Title',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
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
                      ],
                    ),
                    trailing: Text(
                      timeAgo,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}