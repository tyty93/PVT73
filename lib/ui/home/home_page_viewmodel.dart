// todo:  inject authrepository into homeviewmodel,
//  call it in homepge instead of it having its own logout func
//  void logout() {
//     _authRepository.logout();
//   }
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/auth_repository.dart';
import 'package:flutter_application_1/ui/event/event_page.dart';
import 'package:flutter_application_1/ui/home/home_page.dart';

import '../../data/models/event.dart';

class HomeViewmodel extends ChangeNotifier {
  final AuthRepository _authRepository;
  // final List<Event> _events = _eventRepository.list??;


  HomeViewmodel({required AuthRepository authRepository}) : _authRepository = authRepository;

  //UnmodifiableListView<Event> get events => UnmodifiableListView(_events);

  void signOut() {
    _authRepository.signOut();
  }
}