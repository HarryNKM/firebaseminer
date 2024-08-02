import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  static FirestoreHelper helper = FirestoreHelper._();

  FirestoreHelper._();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getAllUsers() {
    return firestore.collection("users").snapshots().map(
      (snapshot) {
        return snapshot.docs.map(
          (doc) {
            final user = doc.data();
            return user;
          },
        ).toList();
      },
    );
  }
}
