import 'package:flutter/material.dart';


class SignInPage extends StatelessWidget {
  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      // TODO: implement
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
