import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('users');

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static String? userUid;
  initiliase() {
    _firestore;
  }

  static Future<void> addUser({
    required String name,
    required String email,
    required String number,
    required String address,
  }) async {
    String id;

    final docUser = FirebaseFirestore.instance.collection('users').doc();
    id = docUser.id;

    Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'number': number,
      'address': address,
    };

    _collection.add(data);
  }

  final Stream<QuerySnapshot> userStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  static Future<void> updateUser({
    required String name,
    required String email,
    required String number,
    required String address,
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _collection.doc(userUid).collection('users').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      'name': name,
      'email': email,
      'number': number,
      'address': address
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("User updated"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteUser({
    required String docId,
  }) async {
    DocumentReference documentReferencer =
        _collection.doc(userUid).collection('users').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('User deleted'))
        .catchError((e) => print(e));
  }
}
