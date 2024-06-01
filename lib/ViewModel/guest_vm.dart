import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forever_bond/Model/guest.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GuestVM {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'guests';

  Future<void> addGuest(Guest guest) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await _firestore
          .collection('users')
          .doc(user.email)
          .collection(_collectionName)
          .doc(guest.id)
          .set(guest.toJson());
    } catch (e) {
      throw Exception('Failed to add guest: $e');
    }
  }

  Stream<List<Guest>> getGuests() async* {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      yield* _firestore
          .collection('users')
          .doc(user.email)
          .collection(_collectionName)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) => Guest.fromJson(doc.data())).toList();
      });
    } catch (e) {
      throw Exception('Failed to get guests: $e');
    }
  }

  Future<void> updateGuest(Guest guest) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await _firestore
          .collection('users')
          .doc(user.email)
          .collection(_collectionName)
          .doc(guest.id)
          .update(guest.toJson());
    } catch (e) {
      throw Exception('Failed to update guest: $e');
    }
  }

  Future<void> deleteGuest(String guestId) async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await _firestore
          .collection('users')
          .doc(user.email)
          .collection(_collectionName)
          .doc(guestId)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete guest: $e');
    }
  }
}
