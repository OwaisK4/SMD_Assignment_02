// lib/repositories/auth_repository.dart
import 'package:firebase_auth/firebase_auth.dart';

class AuthUser {
  final String uid;
  final bool isAnonymous;

  AuthUser({required this.uid, required this.isAnonymous});
}

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<AuthUser?> get user => _firebaseAuth.authStateChanges().map(
    (user) =>
        user != null
            ? AuthUser(uid: user.uid, isAnonymous: user.isAnonymous)
            : null,
  );

  Future<void> signUp(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signInAnonymously() async {
    await _firebaseAuth.signInAnonymously();
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
