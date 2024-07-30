import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonationsAlertsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Donation Alerts'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('notifications')
          .where('recipientId', isEqualTo: user?.uid)
          .orderBy('timestamp', descending: true)
          .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var notifications = snapshot.data?.docs;

          return ListView.builder(
            itemCount: notifications?.length,
            itemBuilder: (context, index) {
              var notification = notifications?[index];
              return ListTile(
                title: Text(notification?['message']),
                subtitle: Text(notification!['timestamp'].toDate().toString()),
              );
            },
          );
        },
      ),
    );
  }
}
