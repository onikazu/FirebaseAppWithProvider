import 'dart:io';

import 'package:firebase_app_with_provider/services/firestore_path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';


class FirebaseStorageService {
  Future<String> uploadAvatar(
    {@required String uid, @required File file}) async =>
    await upload(
      uid: uid,
      file: file,
      path: FirestorePath.avatar(uid) + "/avatar.png",
      contentType: "image/png",
    );

  Future<String> upload(
    {@required String uid, @required File file, @required String path, @required String contentType,}) async {
    print("uploading to: $path");
    final storageReference = FirebaseStorage.instance.ref().child(path);
    final uploadTask = storageReference.putFile(
      file, StorageMetadata(contentType: contentType)
    );
    final snapshot = await uploadTask.onComplete;
    if (snapshot.error != null) {
      // firebase側の設定が済んでいるか確認する。
      print("upload error code: ${snapshot.error}");
      throw snapshot.error;
    }
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print("downloadUrl: $downloadUrl");
    return downloadUrl;
  }
}