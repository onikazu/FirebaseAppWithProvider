import 'dart:async';

import 'package:firebase_app_with_provider/app/home/about_page.dart';
import 'package:firebase_app_with_provider/common_widgets/avatar.dart';
import 'package:firebase_app_with_provider/models/avatar_reference.dart';
import 'package:firebase_app_with_provider/services/firebase_auth_service.dart';
import 'package:firebase_app_with_provider/services/firebase_storage_service.dart';
import 'package:firebase_app_with_provider/services/firestore_service.dart';
import 'package:firebase_app_with_provider/services/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<FirebaseAuthService>(context);
      print("sign out");
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onAbout(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => AboutPage(),
      ),
    );
  }

  Future<void> _chooseAvatar(BuildContext context) async {
    try {
      // 1. get image from picker
      final imagePicker = Provider.of<ImagePickerService>(context);
      final file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        // 2. Upload to storage
        final user = Provider.of<User>(context, listen: false);
        final storage = Provider.of<FirebaseStorageService>(context);
        final downloadUrl = await storage.uploadAvatar(
          uid: user.uid, file: file);
        // 3. Save url to Firebase
        final database = Provider.of<FirestoreService>(context);
        await database.setAvatarReference(
          uid: user.uid,
          avatarReference: AvatarReference(downloadUrl)
        );
        // 4. (optional) delete local file as no longer needed
        await file.delete();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        leading: IconButton(
          icon: Icon(Icons.help),
          onPressed: () => _onAbout(context),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Logout",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => _signOut(context),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130.0),
          child: Column(
            children: <Widget>[
              _buildUserInfo(context: context),
              SizedBox(height: 16)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo({BuildContext context}) {
    final database = Provider.of<FirestoreService>(context);
    final user = Provider.of<User>(context, listen: false);
    return StreamBuilder<AvatarReference>(
      stream: database.avatarReferenceStream(uid: user.uid),
      builder: (context, snapshot) {
        final avatarReference = snapshot.data;
        return Avatar(
          photoUrl: avatarReference?.downloadUrl,
          radius: 50,
          borderColor: Colors.black54,
          borderWidth: 2.0,
          onPressed: () => _chooseAvatar(context),
        );
      },
    );
  }
}






























