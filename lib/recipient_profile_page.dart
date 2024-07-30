import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipientProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipient Profile'),
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
              const Text('Needs:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextFormField(
                initialValue: userData?['needs'],
                decoration: const InputDecoration(labelText: 'Needs'),
              ),
              const SizedBox(height: 20),
              const Text('Capacity:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextFormField(
                initialValue: userData?['capacity'].toString(),
                decoration: const InputDecoration(labelText: 'Capacity'),
              ),
            ],
          );
        },
      ),
    );
  }
}
