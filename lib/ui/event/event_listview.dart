import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/event/event_card.dart';

import '../../data/models/event.dart';

class EventListview extends StatelessWidget {
  final List<Event>? events;
  const EventListview({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    if (events == null) {
      return Center(child: Text('No events available'));
    }
    return ListView.builder(
        itemBuilder: (context, index) {
          return EventCard(
            eventName: events![index].name,
            eventDescription: events![index].description,
          );
        },
        itemCount: events?.length
    );
  }
}
