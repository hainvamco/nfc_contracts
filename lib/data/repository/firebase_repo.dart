import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nfc_contracts/data/model/user_firebase.model.dart';

class FirebaseRepo {
  final CollectionReference<Map<String, dynamic>> _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<UsersFirebase> getUserById({required String idUser}) async {
    DocumentSnapshot<UsersFirebase> snapshot = await _userCollection
        .doc(idUser)
        .withConverter(
            fromFirestore: (snap, options) =>
                UsersFirebase.fromJson(snap.data() ?? {}),
            toFirestore: (value, options) => value.toJson())
        .get();

    return snapshot.data() ?? UsersFirebase();
  }

  Stream<UsersFirebase> userFirebaseStream({required String idUser}) {
    return _userCollection
        .doc(idUser)
        .withConverter(
            fromFirestore: (snap, option) =>
                UsersFirebase.fromJson(snap.data() ?? {}),
            toFirestore: (value, option) => value.toJson())
        .snapshots()
        .map(
      (event) {
        return event.data() ?? UsersFirebase();
      },
    );
  }
}
