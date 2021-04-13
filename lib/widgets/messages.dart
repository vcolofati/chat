import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference chats = FirebaseFirestore.instance.collection('chat');
    return StreamBuilder<QuerySnapshot>(
      stream: chats.snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data?.docs;
        return ListView.builder(
          itemCount: chatDocs?.length,
          itemBuilder: (ctx, i) => Text(
            chatDocs?[i]['text'],
          ),
        );
      },
    );
  }
}
