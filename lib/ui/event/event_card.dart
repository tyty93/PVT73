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
    return SizedBox(
      height: 112,
      child: Card.filled(
        child: Center(
          child: ListTile(
            leading: CircleAvatar(), // Todo fix CircleAvatar to work as image placeholder backgroundImage: NetworkImage(userAvatarUrl),
            title: Text(eventName),
            subtitle: Text(eventDescription),
            trailing: Icon(Icons.info_outline),
            // todo add information about date, time and participants
            onTap: () {}, // Todo onTap "View Event details" (Navigator.push)
          ),
        ),
      ),
    );
  }
}
