import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final int index;

  const EventCard({
    super.key,
    required this.event,
    required this.index
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card.filled(
        color: index.isEven ? Theme.of(context).colorScheme.surfaceContainerHigh : Theme.of(context).colorScheme.surfaceContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: CircleAvatar(), // Todo fix CircleAvatar to work as image placeholder backgroundImage: NetworkImage(userAvatarUrl),
              title: Text(event.name),
              subtitle: Text(event.description),
              trailing: Icon(Icons.info_outline),
              // todo add information about date, time and participants
              onTap: () {
                final eventId = event.eventId;
                context.push('/home/event/$eventId', extra: event);
              }
            ),
          ],
        ),
      ),
    );
  }
}