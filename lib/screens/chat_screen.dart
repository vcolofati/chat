import 'package:chat/utils/hash_generator.dart';
import 'package:chat/widgets/custom_dropdown_menu.dart';
import 'package:chat/widgets/messages.dart';
import 'package:chat/widgets/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final User user;
  final QueryDocumentSnapshot friend;

  ChatScreen(this.user, this.friend);

  @override
  Widget build(BuildContext context) {
    CollectionReference chat = FirebaseFirestore.instance
        .collection('chats')
        .doc(HashGenerator.genHash(user.uid, friend.id))
        .collection('messages');

    return Scaffold(
      appBar: AppBar(
        title: Text(friend.get('name')),
        actions: [
          CustomDropDownMenu(),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages(chat, user)),
            NewMessage(chat, user),
          ],
        ),
      ),
    );
  }
}
