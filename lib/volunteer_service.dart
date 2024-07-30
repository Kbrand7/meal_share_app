import 'package:cloud_firestore/cloud_firestore.dart';

class VolunteerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> assignVolunteer(String donationId, String volunteerId) async {
    await _firestore.collection('volunteerAssignments').add({
      'donationId': donationId,
      'volunteerId': volunteerId,
    });
  }
}
