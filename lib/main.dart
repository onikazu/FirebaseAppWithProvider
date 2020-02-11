import 'package:firebase_app_with_provider/app/auth_widget.dart';
import 'package:firebase_app_with_provider/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<FirebaseAuthService>(
      create: (_) => FirebaseAuthService(),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: AuthWidget(),
      ),
    );
  }
}
