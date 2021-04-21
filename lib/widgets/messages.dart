import 'package:chat/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  final CollectionReference chat;
  final User user;

  Messages(this.chat, this.user);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: chat.orderBy('createdAt', descending: true).snapshots(),
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
            chatDocs?[i].get('text'),
            chatDocs?[i].get('createdAt').toDate(),
            chatDocs?[i].get('userId') == user.uid,
            key: ValueKey(chatDocs?[i].id),
          ),
        );
      },
    );
  }
}
