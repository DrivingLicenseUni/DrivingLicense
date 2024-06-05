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
          .collection('notifications')
          .doc(userId)
          .collection('student_notifications')
          .orderBy('sentTime', descending: true)
          .get();

      List<Map<String, dynamic>> notifications = querySnapshot.docs.map((doc) {
        return {
          'title': doc['title'],
          'body': doc['body'],
          'sentTime': doc['sentTime'],
          'photoUrl': _getPhotoUrlForTitle(doc['title']),
        };
      }).toList();

      setState(() {
        _notifications = notifications;
      });
    }
  }

  String _getPhotoUrlForTitle(String? title) {
    switch (title) {
      case 'Appointment Reminder':
        return 'assets/images/appo_reminder.png';
      case 'Lesson Progress Update':
        return 'assets/images/less_pro_update.png';
      case 'New Study Material':
        return 'assets/images/new_study_mat.png';
      default:
        return '';
    }
  }

  Future<void> _clearNotificationData() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      var snapshots = await _firestore
          .collection('notifications')
          .doc(userId)
          .collection('student_notifications')
          .get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
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
              padding: EdgeInsets.all(8.0),
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
                    contentPadding: EdgeInsets.all(5.0),
                    leading: notification['photoUrl'] != null && notification['photoUrl'].isNotEmpty
                        ? Image.asset(
                      notification['photoUrl'],
                      width: 50,
                      height: 50,
                    )
                        : Container(width: 40, height: 40),
                    title: Text(
                      notification['title'] ?? 'No Title',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold , color: Colors.black),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5.0),
                        Text(
                          notification['body'] ?? 'No Body',
                          style: AppTextStyles.headline.copyWith(
                            fontSize: 12.0,
                            color: AppColors.gray,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.0),
                      ],
                    ),
                    trailing: Text(
                      timeAgo,
                      style: TextStyle(fontSize:12.0 , color: AppColors.primary,fontWeight: FontWeight.bold),
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
