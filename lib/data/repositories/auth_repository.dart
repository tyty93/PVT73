import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/data/services/auth_service.dart';

abstract class AuthRepository {

  Stream<User?> get authStateChanges;

  Future<UserCredential> signUpWithEmailAndPassword(String email, String password);

  Future<UserCredential> signInWithEmailAndPassword(String email, String password);

  Future<UserCredential> signInWithGoogle();

  Future<void> signOut();
}

class AuthRepositoryImpl implements AuthRepository {

  final AuthService _authService;
  AuthRepositoryImpl(this._authService);

  @override
  Stream<User?> get authStateChanges => _authService.authStateChanges;

  @override
  Future<UserCredential> signUpWithEmailAndPassword(String email, String password) {
    return _authService.signUpWithEmailAndPassword(email, password);
  }
  
  @override
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) {
    return _authService.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<UserCredential> signInWithGoogle() {
    return _authService.signInWithGoogle();
  }

  @override
  Future<void> signOut() {
    return _authService.signOut();
  }
}