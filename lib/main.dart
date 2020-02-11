import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_with_provider/app/auth_widget.dart';
import 'package:firebase_app_with_provider/services/firebase_auth_service.dart';
import 'package:firebase_app_with_provider/services/firebase_storage_service.dart';
import 'package:firebase_app_with_provider/services/firestore_service.dart';
import 'package:firebase_app_with_provider/services/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(create: (_) => FirebaseAuthService()),
        Provider<ImagePickerService>(create: (_) => ImagePickerService()),
        Provider<FirebaseStorageService>(create: (_) => FirebaseStorageService()),
        Provider<FirestoreService>(create: (_) => FirestoreService(),)
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.indigo),
        home: AuthWidget(),
        ),
    );
  }
}
