
import 'package:flutter/cupertino.dart';

import '../../data/models/event.dart';
import '../../data/repositories/event_repository.dart';

// todo: refactor how events is handled?
class EventsViewmodel extends ChangeNotifier {
  List<Event>? _events;
  bool _hasLoadedEvents = false;
  final EventRepository _eventRepository;

  EventsViewmodel({required EventRepository eventRepository}) :
        _eventRepository = eventRepository;

  List<Event>? get events => _events;

  Future<void> loadEvents() async {
    if (_hasLoadedEvents) return;
    _hasLoadedEvents = true;
    _events = await _eventRepository.fetchEvents();
    _events?.sort((a, b) => a.dateTime.compareTo(b.dateTime)); // Events sorted by date by default
    notifyListeners();
  }


}
