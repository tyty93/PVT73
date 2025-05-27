import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/auth_repository.dart';
import 'package:flutter_application_1/data/repositories/user_repository.dart';
import 'package:flutter_application_1/data/repositories/event_repository.dart';
import '../../data/models/event.dart';

class HomeViewmodel extends ChangeNotifier {
  List<Event>? _ownedEvents;
  // List<Event>? _participatingInEvents;

  bool _hasLoadedOwnedEvents = false;
  List<Event>? _participatingInEvents;
  bool _hasLoadedParticipatingEvents = false;


  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final EventRepository _eventRepository;
  
  List<Event>? get participatingInEvents => _participatingInEvents;
  bool get hasLoadedParticipatingEvents => _hasLoadedParticipatingEvents;


  HomeViewmodel({
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required EventRepository eventRepository,
  }) : _authRepository = authRepository, _userRepository = userRepository, _eventRepository = eventRepository {
    _authRepository.authStateChanges.listen((user) {
    if (user != null) {
      _loadAllEvents();
    }
  });
  }

  List<Event>? get ownedEvents => _ownedEvents;
  bool get hasLoadedOwnedEvents => _hasLoadedOwnedEvents;

  // triggered during constructor
  Future<void> _loadOwnedEvents() async {
    if (_hasLoadedOwnedEvents) return;
    _hasLoadedOwnedEvents = true;
    _ownedEvents = await _userRepository.fetchOwnedEvents();
    _ownedEvents?.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    notifyListeners();
  }
  void _loadAllEvents() {
  _loadOwnedEvents();
  _loadParticipatingEvents();
  }

  Future<void> _loadParticipatingEvents() async {
    if (_hasLoadedParticipatingEvents) return;
    _hasLoadedParticipatingEvents = true;
    _participatingInEvents = await _userRepository.fetchParticipatingEvents();
    _participatingInEvents?.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    notifyListeners();
  }

  Future<void> refreshAllEvents() async {
    _hasLoadedOwnedEvents = false;
    _hasLoadedParticipatingEvents = false;
    _loadAllEvents();
  }
  
  void signOut() {
    _authRepository.signOut();
    _ownedEvents?.clear();
    _participatingInEvents?.clear();
    _hasLoadedOwnedEvents = false;
    _hasLoadedParticipatingEvents = false;
    notifyListeners();
  }

  Future<void> createEvent({
    required String name,
    required String description,
    required String location,
    required DateTime dateTime,
    required int maxAttendees,
    required int cost,
    required String paymentInfo
  }) async {
    try {
      // create event on backend and receive the created event (with ID)
      final createdEvent = await _eventRepository.createEvent(
        name: name,
        description: description,
        location: location,
        dateTime: dateTime,
        maxAttendees: maxAttendees,
        cost: cost,
        paymentInfo: paymentInfo
      );

      // add only the confirmed event from backend
      _ownedEvents ??= []; // if events is null, ensure its at least an empty list
      _ownedEvents!.add(createdEvent);
      _ownedEvents!.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to create new event: $e');
    }
  }

  Future<void> deleteEvent(Event event) async {
    // find the event in the list, based on equality of its id compared to argument events id
    final removedEvent = ownedEvents?.firstWhereOrNull((e) => e.eventId == event.eventId);

    // safety guard, return if nothing to remove
    if (removedEvent == null) return;

    // optimistic removal locally to update listviews quickly
    ownedEvents?.remove(removedEvent);
    notifyListeners();

    try {
      // attempt removal by id in backend
      await _eventRepository.deleteEvent(event.eventId);
    } catch (e) {
      // if remote removal failed, re-add the removed event to local list
      ownedEvents?.add(removedEvent);
      //_ownedEvents = List.from(_ownedEvents!)..add(removedEvent);
      notifyListeners();
      rethrow;
    }
  }
}