import 'package:firebase_app_with_provider/app/home/home_page.dart';
import 'package:firebase_app_with_provider/app/sign_in/sign_in_page.dart';
import 'package:firebase_app_with_provider/services/firebase_auth_service.dart';
import 'package:firebase_app_with_provider/services/firebase_storage_service.dart';
import 'package:firebase_app_with_provider/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key key, @required this.builder}) : super(key:key);
  final Widget Function(BuildContext, AsyncSnapshot<User>) builder;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<FirebaseAuthService>(context, listen: false);
    return StreamBuilder<User>(
      stream: authService.onAuthStateChanged,
      builder: (context, snapshot) {
        final user = snapshot.data;
        if (user != null) {
          return MultiProvider(
            providers: [
              Provider<User>.value(value: user),
              Provider<FirebaseStorageService>(
                create: (_) => FirebaseStorageService(uid: user.uid),
              ),
              Provider<FirestoreService>(
                create: (_) => FirestoreService(uid: user.uid),
              ),
            ],
            child: builder(context, snapshot),
          );
        }
        return builder(context, snapshot);
      },
    );
  }
}
