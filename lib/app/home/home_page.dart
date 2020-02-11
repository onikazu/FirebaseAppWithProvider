import 'dart:async';

import 'package:firebase_app_with_provider/app/home/about_page.dart';
import 'package:firebase_app_with_provider/common_widgets/avatar.dart';
import 'package:firebase_app_with_provider/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
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
      // TODO: implement
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
    // TODO: download and show avator from firebase storage
    return Avatar(
      photoUrl: null,
      radius: 50,
      borderColor: Colors.black54,
      borderWidth: 2.0,
      onPressed: () => _chooseAvatar(context)
    );
  }
}






























