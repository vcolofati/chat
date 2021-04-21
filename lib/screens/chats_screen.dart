import 'package:chat/screens/chat_screen.dart';
import 'package:chat/widgets/custom_dropdown_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    User user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text('Amigos'),
        actions: [CustomDropDownMenu()],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: users.orderBy('name').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final usersList = snapshot.data?.docs;
            return ListView.builder(
                itemCount: usersList!.length,
                itemBuilder: (context, i) {
                  if (usersList[i].id == user.uid) {
                    return const SizedBox.shrink();
                  }
                  final QueryDocumentSnapshot friend = usersList[i];
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(user, friend),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(friend.get('imageUrl')),
                            ),
                          ),
                          Text(
                            friend.get('name'),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
