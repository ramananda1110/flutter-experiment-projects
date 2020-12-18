import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  /*Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp();
    assert(app != null);
    print('Initialized default app $app');
  }*/

  @override
  Widget build(BuildContext context) {
    // await Firebase.initializeApp();
    return Scaffold(
        appBar: AppBar(
          title: Text('list view'),
        ),
        body: StreamBuilder(
          stream: Firestore.instance
              .collection('chats/nNDXE8rd3c7eXfz1gks1/messages/')
              .snapshots(),



         builder: (ctx, streamSnapshot)

          {


            return ListView.builder(
                itemCount: 10,
                itemBuilder: (ctx, index)=>Container(
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
