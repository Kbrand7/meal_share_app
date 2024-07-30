import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BrowseDonationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Donations'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('donations').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var donations = snapshot.data?.docs;

          return ListView.builder(
            itemCount: donations?.length,
            itemBuilder: (context, index) {
              var donation = donations?[index];

              if (donation == null || !donation.exists) {
                return const ListTile(
                  title: Text('Invalid donation data'),
                );
              }

              String? donorId;
              String? foodType;
              int? quantity;
              Timestamp? expirationDate;

              try {
                donorId = donation.get('donorId');
                foodType = donation.get('foodType');
                quantity = donation.get('quantity');
                expirationDate = donation.get('expirationDate');
              } catch (e) {
                return ListTile(
                  title: const Text('Invalid donation data'),
                );
              }

              if (foodType == null || quantity == null || expirationDate == null) {
                return const ListTile(
                  title: Text('Invalid donation data'),
                );
              }

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('users').doc(donorId).get(),
                builder: (context, donorSnapshot) {
                  if (!donorSnapshot.hasData) {
                    return ListTile(
                      title: Text(foodType!),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Quantity: $quantity'),
                          Text('Expires: ${expirationDate?.toDate()}'),
                          const Text('Donor: Loading...'),
                        ],
                      ),
                    );
                  }

                  var donorData = donorSnapshot.data;
                  var donorName = donorData?.get('username') ?? 'Unknown Donor';

                  return ListTile(
                    title: Text(foodType!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Quantity: $quantity'),
                        Text('Expires: ${expirationDate?.toDate()}'),
                        Text('Donor: $donorName'),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance.collection('donations').doc(donation.id).update({
                          'status': 'Accepted',
                          'recipientId': user?.uid,
                        });

                        FirebaseFirestore.instance.collection('notifications').add({
                          'userId': donorId,
                          'message': 'Your donation has been accepted by ${user?.email}',
                          'timestamp': Timestamp.now(),
                        });
                      },
                      child: const Text('Receive Donation'),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
