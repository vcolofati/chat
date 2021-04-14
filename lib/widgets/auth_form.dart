import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthData authData) onSubmit;

  AuthForm(this.onSubmit);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final AuthData _authData = AuthData();

  _submit() {
    bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      widget.onSubmit(_authData);
    }
  }

  List<Widget> _createUserFields() {
    return [
      UserImagePicker(),
      TextFormField(
        key: ValueKey('name'),
        initialValue: _authData.getName,
        decoration: InputDecoration(
          labelText: 'Nome',
        ),
        onChanged: (String? value) => _authData.setName = value,
        validator: (value) {
          if (value == '') {
            return 'Name can\'t be null';
          }
          return null;
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_authData.isSignup) ..._createUserFields(),
                  TextFormField(
                    key: ValueKey('email'),
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    onChanged: (String? value) => _authData.setEmail = value,
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Email can\'t be null or not valid';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                    ),
                    onChanged: (String? value) => _authData.setPassword = value,
                    validator: (value) {
                      if (value == null || value.trim().length < 7) {
                        return 'Password can\'t have less than 7 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    child: Text(_authData.isLogin ? 'Entrar' : 'Cadastrar'),
                    onPressed: _submit,
                  ),
                  TextButton(
                    child: Text(_authData.isLogin ? 'Signup' : 'Signin'),
                    onPressed: () {
                      setState(() {
                        _authData.toggleMode();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
