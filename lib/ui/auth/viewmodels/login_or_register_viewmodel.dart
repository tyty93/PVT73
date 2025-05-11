import 'package:flutter/material.dart';
import '../../../data/repositories/auth_repository.dart';

class LoginOrRegisterViewmodel extends ChangeNotifier {
  final AuthRepository _authRepository;
  bool _isLoading = false;
  bool _showLoginPage = true;
  String? _errorMessage;

  LoginOrRegisterViewmodel({required AuthRepository authRepository})
      : _authRepository = authRepository;

  bool get showLoginPage => _showLoginPage;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void togglePages() {
    _showLoginPage = !_showLoginPage;
    notifyListeners();
  }

  Future<void> signUpWithEmailAndPassword(String username, String email, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      _errorMessage = "Passwords do not match.";
      notifyListeners();
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.signUpWithEmailAndPassword(username, email, password);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.signInWithEmailAndPassword(email, password);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> signInWithGoogle() async{
    _isLoading = true;
    notifyListeners();

    try {
      await _authRepository.signInWithGoogle();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}