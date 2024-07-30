import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VolunteerCoordinationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer Coordination'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('volunteers').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var volunteers = snapshot.data?.docs;

          return ListView.builder(
            itemCount: volunteers?.length,
            itemBuilder: (context, index) {
              var volunteer = volunteers?[index];
              return ListTile(
                title: Text(volunteer?['name']),
                subtitle: Text(volunteer?['email']),
                trailing: ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance.collection('assignments').add({
                      'volunteerId': volunteer?.id,
                      'donationId': user?.uid,
                      'status': 'Assigned',
                      'timestamp': Timestamp.now(),
                    });
                  },
                  child: Text('Assign'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
