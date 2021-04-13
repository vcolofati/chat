import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/auth_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void _handleSubmit(AuthData authData) {
    print(authData.getName);
    print(authData.getEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_handleSubmit),
    );
  }
}
