import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // await Firebase.initializeApp();
    return Scaffold(
        appBar: AppBar(
          title: Text('FlutterChat'),
          actions: [
            DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(width: 8,),
                        Text('Logout')
                      ],
                    ),
                  ),
                  value: 'logout' ,
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            )
          ],
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('chats/nNDXE8rd3c7eXfz1gks1/messages/')
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            return ListView.builder(
                itemCount: 10,
                itemBuilder: (ctx, index) => Container(
                      padding: EdgeInsets.all(10),
                      child: Text('is work'),
                    ));

            //*if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
            //*
            //final documents = streamSnapshot.data.toString();
          },
        ));
  }
}
