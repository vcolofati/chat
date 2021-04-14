import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _handleSubmit(AuthData authData) async {
    setState(() {
      _isLoading = true;
    });

    UserCredential userCredential;

    try {
      if (authData.isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: authData.getEmail!.trim(),
          password: authData.getPassword!,
        );
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: authData.getEmail!.trim(),
          password: authData.getPassword!,
        );
        userCredential.user?.updateProfile(displayName: authData.getName);

        final userData = {
          'name': authData.getName,
          'email': authData.getEmail,
        };

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set(userData);
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
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
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
    );
  }
}
