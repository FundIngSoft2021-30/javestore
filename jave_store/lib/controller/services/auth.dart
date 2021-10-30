//@dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum AuthStatus {
  Authenticated,
  Unauthenticated,
}

class AuthService with ChangeNotifier {
  AuthStatus _status = AuthStatus.Unauthenticated;
  User _currentUser;
  final FirebaseAuth _auth;
  AuthService(this._auth);
  get status => _status;
  get currentUser => _currentUser;
  Future<String> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _status = AuthStatus.Authenticated;
      _currentUser = _auth.currentUser;
      notifyListeners();
      return "${_auth.currentUser.uid}";
    } catch (e) {
      return e.message;
    }
  }

  void signOut() {
    _auth.signOut();
    _status = AuthStatus.Unauthenticated;
    notifyListeners();
  }
}
