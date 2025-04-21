import '../models/event.dart';

abstract class EventRepository {
  // todo: Fill with general interface
  Future<List<Event>> fetchEvents();
}

class EventRepositoryImpl implements EventRepository {
  // todo: call external service. For testing: Mock data source for example "mockito"  on local host
  // todo: later, should call our tomcat server? or handle by our databases?
  @override
  Future<List<Event>> fetchEvents() async {
    List<Event> events = [
      Event(name: 'Event1', description: 'Descr1', dateTime: DateTime.now()),
      Event(name: 'Event2', description: 'Descr2', dateTime: DateTime.now()),
      Event(name: 'Event3', description: 'Descr3', dateTime: DateTime.now()),
      Event(name: 'Event4', description: 'Descr4', dateTime: DateTime.now()),
      Event(name: 'Event5', description: 'Descr5', dateTime: DateTime.now()),
      Event(name: 'Event6', description: 'Descr6', dateTime: DateTime.now()),
      Event(name: 'Event7', description: 'Descr7', dateTime: DateTime.now()),
      Event(name: 'Event8', description: 'Descr8', dateTime: DateTime.now()),
      Event(name: 'Event9', description: 'Descr9', dateTime: DateTime.now()),
      Event(name: 'Event10', description: 'Descr10', dateTime: DateTime.now()),
      Event(name: 'Event11', description: 'Descr11', dateTime: DateTime.now()),
    ];
    return events;
  }
}