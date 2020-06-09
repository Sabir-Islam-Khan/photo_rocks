import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  Future<User> signInWithGoogle();
  Stream<User> get onAuthStateChanged;
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

  // stream to add listener
  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
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

  // sign in with google account
  @override
  Future<User> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleAccount = await googleSignIn.signIn();

    if (googleAccount != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleAccount.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final authResult = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: "INVALID TOKEN",
          message: "Token is invalid for this user",
        );
      }
    } else {
      throw PlatformException(
        code: "ABORTED",
        message: "User aborted google sign in",
      );
    }
  }

  // method to sign out
  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
