import 'package:firebase_app_with_provider/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SignInPage extends StatelessWidget {
  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      // TODO: implement
      final auth = Provider.of<FirebaseAuthService>(context);
      final user = await auth.signInAnonymously();
      print("uid: ${user.uid}");
    } catch (e) {
      print(e);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In"),),
      body: Center(
        child: RaisedButton(
          child: Text("Sign in anonymously"),
          onPressed: () => _signInAnonymously(context),
        ),
      ),
    );
  }
}
