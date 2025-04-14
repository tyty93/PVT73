import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/auth_repository.dart';


// Exposes isLoggedIn so auth_page knows whether to return Home or LoginOrRegister pages
// Listens to Firebase auth stream exposed by the AuthRepository
class AuthViewmodel extends ChangeNotifier {
  final AuthRepository _authRepository;
  User? _user;
  late final StreamSubscription<User?> _authSubscription;

  AuthViewmodel({required AuthRepository authRepository})
      : _authRepository = authRepository {
    _authSubscription = _authRepository.authStateChanges.listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  User? get user => _user;
  bool get isLoggedIn => _user != null;


  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }
}