import 'package:flutter/material.dart';

// Builds a Material 3 Filled Card wrapping a Material 3 ListTile
// todo: add more fields such as "Date"
class EventCard extends StatelessWidget {
  final String eventName;
  final String eventDescription;

  const EventCard({
    super.key,
    this.eventName = "Untitled Event",
    this.eventDescription = "No description available.",
  });

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      child: ListTile(
        leading: Icon(Icons.event),
        title: Text(eventName),
        subtitle: Text(eventDescription),
        trailing: Icon(Icons.arrow_right),
        onTap: () {}, // Todo onTap "View Event details" (Navigator.push)
      ),
    );
  }
}
