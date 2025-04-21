// todo:  inject authrepository into homeviewmodel,
//  call it in homepge instead of it having its own logout func
//  void logout() {
//     _authRepository.logout();
//   }
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/auth_repository.dart';

import '../../data/models/event.dart';

final List<Event> testList = [
  Event(
    name: 'Test Event 1',
    description: 'This is a test event.',
    dateTime: DateTime(2025, 4, 16, 17, 30),
  ),
  Event(
    name: 'Test Event 2',
    description: 'Another test event.',
    dateTime: DateTime(2025, 4, 17, 9, 25),
  ),
];

class HomeViewmodel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final List<Event> _events = testList;

  HomeViewmodel({required AuthRepository authRepository}) : _authRepository = authRepository;

  UnmodifiableListView<Event> get events => UnmodifiableListView(_events);

  void signOut() {
    _authRepository.signOut();
  }
}