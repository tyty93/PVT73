import 'package:flutter/material.dart';

// Builds a Material 3 Filled Card wrapping a Material 3 ListTile
// todo: add more fields such as "Date"
class EventCard extends StatelessWidget {
  final String eventName;
  final String eventDescription;
  final int index;

  const EventCard({
    super.key,
    this.eventName = "Untitled Event",
    this.eventDescription = "No description available.",
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Card.filled(
        color: index.isEven ? Theme.of(context).colorScheme.surfaceContainerHigh : Theme.of(context).colorScheme.surfaceContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: CircleAvatar(), // Todo fix CircleAvatar to work as image placeholder backgroundImage: NetworkImage(userAvatarUrl),
              title: Text(eventName),
              subtitle: Text(eventDescription),
              trailing: Icon(Icons.info_outline),
              // todo add information about date, time and participants
              onTap: () {}, // Todo onTap "View Event details" (Navigator.push)
            ),
          ],
        ),
      ),
    );
  }
}
