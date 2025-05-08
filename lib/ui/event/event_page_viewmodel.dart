
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../data/models/event.dart';
import '../../data/repositories/event_repository.dart';

class EventsViewmodel extends ChangeNotifier {
  List<Event>? _availableEvents;
  bool _hasLoadedEvents = false;
  final EventRepository _eventRepository;

  // todo: check if better to expose loadEvents and not call it in constructor
  EventsViewmodel({required EventRepository eventRepository}) :
        _eventRepository = eventRepository {
    _loadAllEvents(); // initialize list
  }

  List<Event>? get availableEvents => _availableEvents;
  bool get hasLoadedEvents => _hasLoadedEvents;

  // todo: catch exceptions thrown from repository
  Future<void> _loadAllEvents() async {
    if (_hasLoadedEvents) return;
    _hasLoadedEvents = true;
    _availableEvents = await _eventRepository.fetchAllEvents();
    _availableEvents?.sort((a, b) => a.dateTime.compareTo(b.dateTime)); // Events sorted by date by default
    notifyListeners();
  }

  // Can be used to re-fetch data. For example triggered by onTaps or pull-down-to-refresh or polling.
  void refreshEvents() {
    _hasLoadedEvents = false;
    _loadAllEvents();
  }

  // todo: place deleteEVent in HomePageViewmodel, and instead put "unregisterFromEvent", also passing the JWT token from firebse
  Future<void> deleteEvent(Event event) async {
    // find the event in the list, based on equality of its id compared to argument events id
    final removedEvent = availableEvents?.firstWhereOrNull((e) => e.eventId == event.eventId);

    // safety guard, return if nothing to remove
    if (removedEvent == null) return;

    // optimistic removal locally to update listviews quickly
    availableEvents?.remove(removedEvent);
    notifyListeners();

    try {
      // attempt removal by id in backend
      await _eventRepository.deleteEvent(event.eventId);
    } catch (e) {
      // if remote removal failed, re-add the removed event to local list
      availableEvents?.add(removedEvent);
      notifyListeners();
      throw Exception('Failed to delete event: $e');
    }
  }

  // todo: change business logic. The event page gives option to join an event (listview, index, event.eventId)
  Future<void> joinEvent({
    required int eventId,
  }) async {

  }
}
