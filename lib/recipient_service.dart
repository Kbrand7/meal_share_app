import 'package:cloud_firestore/cloud_firestore.dart';

class RecipientService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getRecipientProfile(String recipientId) async {
    return await _firestore.collection('recipients').doc(recipientId).get();
  }

  Future<void> updateRecipientProfile(String recipientId, Map<String, dynamic> data) async {
    await _firestore.collection('recipients').doc(recipientId).update(data);
  }
}
