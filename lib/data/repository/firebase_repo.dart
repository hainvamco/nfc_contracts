import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nfc_contracts/data/model/contracts_firebase.model.dart';
import 'package:nfc_contracts/data/model/login_data.model.dart';
import 'package:nfc_contracts/data/model/user_firebase.model.dart';

class FirebaseRepo {
  final CollectionReference<Map<String, dynamic>> _userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference<Map<String, dynamic>> _contractsCollection =
      FirebaseFirestore.instance.collection('contracts');

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

  void updateUserFirebase({required String userId}) {
    _userCollection
        .doc(userId)
        .withConverter(
            fromFirestore: (snap, options) =>
                UsersFirebase.fromJson(snap.data() ?? {}),
            toFirestore: (value, options) => value.toJson())
        .set(UsersFirebase(
          id: '3',
          name: 'changename',
        ));
  }

  Future<LoginData?> findUserInAllContracts(String userId) async {
    try {
      // Lấy tất cả tài liệu từ collection `contracts`
      QuerySnapshot<Map<String, dynamic>> contractsSnapshot =
          await _contractsCollection.get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> contractDoc
          in contractsSnapshot.docs) {
        // Lấy subcollection `users` của từng contract
        var contract = ContractsFirebase.fromJson(contractDoc.data());
        // var name = contractDoc.data()['name'] ?? '';
        print('---name contracts: ${contract.name}');
        print('---@: ${contractDoc.id}');
        var usersSnapshot = await contractDoc.reference
            .collection('users')
            .doc(userId)
            .withConverter(
              fromFirestore: (snap, option) =>
                  UsersFirebase.fromJson(snap.data() ?? {}),
              toFirestore: (val, option) => val.toJson(),
            )
            .get();
        if (usersSnapshot.exists) {
          return LoginData(
            contractData: contract,
            contractsDocId: contractDoc.id,
            userDocId: userId,
            userData: usersSnapshot.data(),
          );
        }
      }

      return LoginData();
    } catch (e) {
      return LoginData();
    }
  }

  String generateRandomId(int length) {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  /// Hàm thêm tài liệu vào collection `contracts` với subcollection `users`
  Future<void> registerContract({
    required String idm,
    required String name,
    required String contractsName,
    required Function(LoginData) onSuccess,
  }) async {
    try {
      String contractId = generateRandomId(10);

      await _contractsCollection.doc(contractId).set({
        'name': contractsName,
      });

      await _contractsCollection
          .doc(contractId)
          .collection('users')
          .doc(idm)
          .set({
        'id': idm,
        'name': name,
      });
      onSuccess(LoginData(
          contractData: ContractsFirebase(name: contractsName, id: contractId),
          userData: UsersFirebase(id: idm, name: name)));
      // onSuccess(
      //     'ContractsId: $contractId \n  Contracts Name: $contractsName \n UserId: $idm \n userName: $name');

      print("Đã thêm contract và user thành công!");
    } catch (e) {
      print("Lỗi khi thêm contract và user: $e");
    }
  }

  Future<void> setTokenUserLogin(
      {required String contractId,
      // required String userId,
      required String tokenFirebase}) async {
    await _contractsCollection.doc(contractId).update({
      'token': tokenFirebase,
    });
    // .collection('users')
    // .doc(idm)
  }
}
