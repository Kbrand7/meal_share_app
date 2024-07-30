import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StatusUpdatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Status Updates'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('donations')
          .where('donorId', isEqualTo: user?.uid)
          .orderBy('timestamp', descending: true)
          .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var donations = snapshot.data?.docs;

          return ListView.builder(
            itemCount: donations?.length,
            itemBuilder: (context, index) {
              var donation = donations?[index];
              return ListTile(
                title: Text(donation?['foodType']),
                subtitle: Text('Status: ${donation?['status'] ?? 'Pending'}'),
              );
            },
          );
        },
      ),
    );
  }
}
