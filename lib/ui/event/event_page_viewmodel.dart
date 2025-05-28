
import 'package:flutter/material.dart';

import '../../data/models/event.dart';
import '../../data/repositories/event_repository.dart';
import '../../data/repositories/user_repository.dart';

class EventsViewmodel extends ChangeNotifier {
  List<Event>? _availableEvents;
  bool _hasLoadedEvents = false;
  List<Event> _registeredEvents = [];
  Future<void> _loadAllEvents() async {
    if (_hasLoadedEvents) return;
    _hasLoadedEvents = true;
    _availableEvents = await _eventRepository.fetchAllEvents();
    _availableEvents?.sort((a, b) => a.dateTime.compareTo(b.dateTime)); // Events sorted by date by default
    notifyListeners();
  }

  // Can be used to re-fetch data. For example triggered by onTaps or pull-down-to-re
  final EventRepository _eventRepository;
  final UserRepository _userRepository;

  // todo: check if better to expose loadEvents and not call it in constructor
  EventsViewmodel({required EventRepository eventRepository, required UserRepository userRepository}) :
        _eventRepository = eventRepository,
        _userRepository = userRepository {
    _loadAllEvents(); // initialize list
    _loadRegisteredEvents();
  }

  List<Event>? get availableEvents => _availableEvents;
  bool get hasLoadedEvents => _hasLoadedEvents;

  // todo: catch exceptions thrown from repositoryfresh or polling.
  Future<void> refreshEvents() async {
    _hasLoadedEvents = false;
    _loadAllEvents();
  }

  Future<void> _loadRegisteredEvents() async {
    _registeredEvents = await _userRepository.fetchParticipatingEvents();
    notifyListeners();
  }

  Future<void> registerToEvent(Event event) async {
    try {
      await _userRepository.addParticipation(event.eventId);
      _registeredEvents.add(event);
      notifyListeners();
    } catch (e) {
      print('Failed to register for event: $e');
    }
  }

  bool isAlreadyRegisteredTo(Event event) {
    return _registeredEvents.any((e) => e.eventId == event.eventId);
  }

  Future<void> unregisterFromEvent(Event event) async {
    await _userRepository.unregisterFromEvent(event.eventId);
    _registeredEvents.removeWhere((e) => e.eventId == event.eventId);
    notifyListeners();
  }
}
