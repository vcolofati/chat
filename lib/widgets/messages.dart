import 'package:chat/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference chats = FirebaseFirestore.instance.collection('chat');
    return StreamBuilder<QuerySnapshot>(
      stream: chats.orderBy('createdAt', descending: true).snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data?.docs;
        return ListView.builder(
          reverse: true,
          itemCount: chatDocs?.length,
          itemBuilder: (ctx, i) => MessageBubble(
            chatDocs?[i]['text'],
            chatDocs?[i]['userId'] == user?.uid,
            key: ValueKey(chatDocs?[i].id),
          ),
        );
      },
    );
  }
}
