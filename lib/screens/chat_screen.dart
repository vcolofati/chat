import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference chats = FirebaseFirestore.instance.collection('chat');
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: chats.snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final querySnapshot = snapshot.data!;
          return ListView.builder(
            itemCount: querySnapshot.size,
            itemBuilder: (ctx, i) => Container(
              padding: const EdgeInsets.all(8),
              child: Text(querySnapshot.docs[i]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          chats.add({
            'text': 'Adicionado manualmente!',
          });
        },
      ),
    );
  }
}
