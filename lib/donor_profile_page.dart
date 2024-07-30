import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonorProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Donor Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(user?.uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var userData = snapshot.data?.data() as Map<String, dynamic>?;

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              Text('Name: ${userData?['name']}', style: const TextStyle(fontSize: 20)),
              Text('Email: ${userData?['email']}', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              const Text('Past Donations:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('donations')
                  .where('donorId', isEqualTo: user?.uid)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
                builder: (context, donationSnapshot) {
                  if (!donationSnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  var donations = donationSnapshot.data?.docs;

                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: donations?.length,
                    itemBuilder: (context, index) {
                      var donation = donations?[index];
                      return ListTile(
                        title: Text(donation?['foodType']),
                        subtitle: Text('Quantity: ${donation?['quantity']}, Expiration Date: ${donation?['expirationDate'].toDate()}'),
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
