
import 'package:flutter/material.dart';

import '../../data/models/event.dart';
import '../../data/repositories/event_repository.dart';

class EventsViewmodel extends ChangeNotifier {
  List<Event>? _events;
  bool _hasLoadedEvents = false;
  final EventRepository _eventRepository;

  EventsViewmodel({required EventRepository eventRepository}) :
        _eventRepository = eventRepository;

  List<Event>? get events => _events;
  bool get hasLoadedEvents => _hasLoadedEvents;

  Future<void> loadEvents() async {
    if (_hasLoadedEvents) return;
    _hasLoadedEvents = true;
    _events = await _eventRepository.fetchEvents();
    _events?.sort((a, b) => a.dateTime.compareTo(b.dateTime)); // Events sorted by date by default
    notifyListeners();
  }

  // Can be used to re-fetch data. For example triggered by onTaps or pull-down-to-refresh or polling.
  void refreshEvents() {
    _hasLoadedEvents = false;
    loadEvents();
  }
}
