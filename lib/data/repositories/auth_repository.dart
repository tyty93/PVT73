import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/data/services/auth_service.dart';

import '../services/user_service.dart';

abstract class AuthRepository {

  Stream<User?> get authStateChanges;

  Future<UserCredential> signUpWithEmailAndPassword(String username, String email, String password);

  Future<UserCredential> signInWithEmailAndPassword(String email, String password);

  Future<UserCredential> signInWithGoogle();

  Future<void> signOut();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService;
  final UserService _userService;
  AuthRepositoryImpl(this._authService, this._userService);

  @override
  Stream<User?> get authStateChanges => _authService.authStateChanges;

  @override
  Future<UserCredential> signUpWithEmailAndPassword(String username, String email, String password) async {
    final userCredential = await _authService.signUpWithEmailAndPassword(email, password);
    userCredential.user?.getIdToken();
    String userUid = userCredential.user?.uid ?? '';
    String identifier = userCredential.user?.email ?? '';
    if (userUid.isNotEmpty && identifier.isNotEmpty) {
      await _userService.createUser(id: userUid, name: username, email: email); // todo: fix.. hardcoded other values in User that has nothing to do with firebse!
    }
    return userCredential;
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) {
    return _authService.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    final userCredential = await _authService.signInWithGoogle();
    final user = userCredential.user;
    final userUid = user?.uid ?? '';
    final fullGmail = user?.email ?? '';
    assert (fullGmail.contains('@'));
    final gmailName = fullGmail.split('@')[0]; // abc123@gmail.com gives username abc123

    print(userUid);
    print(gmailName);
    print(fullGmail);
    if (userUid.isNotEmpty && gmailName.isNotEmpty) {
      await _userService.createUser(
        id: userUid,
        name: gmailName,
        email: fullGmail,
      );
    }

    return userCredential;
  }

  @override
  Future<void> signOut() {
    return _authService.signOut();
  }
}