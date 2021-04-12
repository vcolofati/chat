enum AuthMode {
  LOGIN,
  SIGNUP,
}

class AuthData {
  String? _name;
  String? _email;
  String? _password;
  AuthMode _mode = AuthMode.LOGIN;

  String? get getName {
    return _name;
  }

  set setName(String? name) {
    _name = name;
  }

  String? get getEmail {
    return _email;
  }

  set setEmail(String? email) {
    _email = email;
  }

  String? get getPassword {
    return _password;
  }

  set setPassword(String? password) {
    _password = password;
  }

  bool get isSignup {
    return _mode == AuthMode.SIGNUP;
  }

  bool get isLogin {
    return _mode == AuthMode.LOGIN;
  }

  void toggleMode() {
    _mode = _mode == AuthMode.LOGIN ? AuthMode.SIGNUP : AuthMode.LOGIN;
  }
}
