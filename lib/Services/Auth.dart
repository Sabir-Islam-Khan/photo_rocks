import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

// user class
class User {
  User({@required this.uid});
  final String uid;
}

// abstract class for global paging

abstract class AuthBase {
  Future<User> currentUser();
  Future<User> signInWithEmail(String mail, String password);
  Future<void> signOut();
  Future<User> createAccountWithEmail(String mail, String password);
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  // method to use firebase user only here
  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    } else {
      return User(uid: user.uid);
    }
  }

// method to get current user info
  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  // method to sign in with email and password
  @override
  Future<User> signInWithEmail(String mail, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<User> createAccountWithEmail(String mail, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: mail,
      password: password,
    );
    return _userFromFirebase(authResult.user);
  }

  // method to sign out
  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
