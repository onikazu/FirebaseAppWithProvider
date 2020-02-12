import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_with_provider/models/avatar_reference.dart';
import 'package:firebase_app_with_provider/services/firestore_path.dart';
import 'package:flutter/cupertino.dart';

class FirestoreService {
  FirestoreService({@required this.uid}): assert(uid != null);
  final String uid;

  Future<void> setAvatarReference(AvatarReference avatarReference) async {
    final path = FirestorePath.avatar(uid);
    final reference = Firestore.instance.document(path);
    await reference.setData(avatarReference.toMap());
  }

  Stream<AvatarReference> avatarReferenceStream(){
    final path = FirestorePath.avatar(uid);
    final reference = Firestore.instance.document(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => AvatarReference.fromMap(snapshot.data));
  }
}