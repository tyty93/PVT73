// todo:  inject authrepository into homeviewmodel,
//  call it in homepge instead of it having its own logout func
//  void logout() {
//     _authRepository.logout();
//   }
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/auth_repository.dart';


class HomeViewmodel extends ChangeNotifier {
  final AuthRepository _authRepository;

  HomeViewmodel({required AuthRepository authRepository}) : _authRepository = authRepository;

  void signOut() {
    _authRepository.signOut();
  }
}