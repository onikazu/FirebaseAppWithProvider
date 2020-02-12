import 'package:firebase_app_with_provider/app/home/home_page.dart';
import 'package:firebase_app_with_provider/app/sign_in/sign_in_page.dart';
import 'package:firebase_app_with_provider/services/firebase_auth_service.dart';
import 'package:firebase_app_with_provider/services/firebase_storage_service.dart';
import 'package:firebase_app_with_provider/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key key, @required this.userSnapshot}): super(key: key);
  final AsyncSnapshot<User> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if (userSnapshot.connectionState == ConnectionState.active) {
      return userSnapshot.hasData ? HomePage() : SignInPage();
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );

  }
}
