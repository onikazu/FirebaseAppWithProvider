import 'package:firebase_app_with_provider/common_widgets/avatar.dart';
import 'package:firebase_app_with_provider/models/avatar_reference.dart';
import 'package:firebase_app_with_provider/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
        // TODO: implement
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Advanced Provider Tutorial",
              style: Theme.of(context).textTheme.headline,
            ),
            SizedBox(height: 32,),
            Text(
              "by Andrea Bizzotto",
              style: Theme.of(context).textTheme.title,
            ),
            SizedBox(height: 32,),
            Text(
              "codingwithflutter.com",
              style: Theme.of(context).textTheme.title,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo({BuildContext context}) {
    final database = Provider.of<FirestoreService>(context);
    return StreamBuilder<AvatarReference>(
      stream: database.avatarReferenceStream(),
      builder: (context, snapshot){
        final avatarReference = snapshot.data;
        return Avatar(
          photoUrl: avatarReference?.downloadUrl,
          radius: 50,
          borderColor: Colors.black54,
          borderWidth: 2.0,
        );
      },
    );
  }
}
