// todo:  inject authrepository into homeviewmodel,
//  call it in homepge instead of it having its own logout func
//  void logout() {
//     _authRepository.logout();
//   }

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/auth_repository.dart';
import 'package:flutter_application_1/data/repositories/event_repository.dart';

import '../../data/models/event.dart';


class HomeViewmodel extends ChangeNotifier {
  List<Event>? _createdEvents;
  bool _hasLoadedEvents = false;

  final AuthRepository _authRepository;
  final EventRepository _eventRepository;

  HomeViewmodel({
    required AuthRepository authRepository,
    required EventRepository eventRepository
  }) : _authRepository = authRepository, _eventRepository = eventRepository {
    _loadCreatedEvents();
  }

  List<Event>? get createdEvents => _createdEvents;
  bool get hasLoadedEvents => _hasLoadedEvents;

  Future<void> _loadCreatedEvents() async {
    if (_hasLoadedEvents) return;
    _hasLoadedEvents = true;
    _createdEvents = await _eventRepository.fetchCreatedEvents();
    _createdEvents?.sort((a, b) => a.dateTime.compareTo(b.dateTime)); // Events sorted by date by default
    notifyListeners();
  }

  void signOut() {
    _authRepository.signOut();
  }

  // todo implement
  Future<void> createEvent({
    required String name,
    required String description,
    required String theme,
    required String location,
    required DateTime dateTime,
    required int maxAttendees
  }) async {
    try {
      // create event on backend and receive the created event (with ID)
      final createdEvent = await _eventRepository.createEvent(
        name: name,
        description: description,
        theme: theme,
        location: location,
        dateTime: dateTime,
        maxAttendees: maxAttendees
      );

      // add only the confirmed event from backend
      _createdEvents ??= []; // if events is null, ensure its at least an empty list
      _createdEvents!.add(createdEvent);
      _createdEvents!.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to create new event: $e');
    }
  }
}