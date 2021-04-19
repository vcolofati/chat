import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/auth_form.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthData authData) async {
    if (this.mounted) {
      setState(() {
        _isLoading = true;
      });
    }

    UserCredential userCredential;

    try {
      if (authData.isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: authData.email!.trim(),
          password: authData.password!,
        );
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: authData.email!.trim(),
          password: authData.password!,
        );

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredential.user?.uid}.jpg');

        await ref.putFile(authData.image!);

        final String url = await ref.getDownloadURL();

        userCredential.user
            ?.updateProfile(displayName: authData.name, photoURL: url);
      }
    } on FirebaseAuthException catch (err) {
      final msg = err.message ?? 'Occurred an error. Check your credentials!';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    } catch (err) {
      print(err);
    } finally {
      if (this.mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  AuthForm(_handleSubmit),
                  if (_isLoading)
                    Positioned.fill(
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
