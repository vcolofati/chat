import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  Future<void> _handleSubmit(AuthData authData) async {
    try {
      if (authData.isLogin) {
        await _auth.signInWithEmailAndPassword(
          email: authData.getEmail!.trim(),
          password: authData.getPassword!,
        );
      } else {
        await _auth.createUserWithEmailAndPassword(
          email: authData.getEmail!.trim(),
          password: authData.getPassword!,
        );
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_handleSubmit),
    );
  }
}
