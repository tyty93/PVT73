import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../data/models/event.dart';
import 'event_info_viewmodel.dart';
import '../../data/repositories/event_info_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';


// Todo: fix colors (either apply theme colors manually or change from basic Container/Column stuff to more material-like widgets with automaticaally applied pr
class EventInfoPage extends StatelessWidget {
  final Event event;

  const EventInfoPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text('Event ${event.eventId}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text('Arrangör: ${event.ownerName}'), 
                  ],
                ),
              ),
            ),
            if (event.ownerId == FirebaseAuth.instance.currentUser?.uid)
              ElevatedButton.icon(
                icon: Icon(Icons.edit, color: Colors.white),
                label: Text('Edit'),
                style: ElevatedButton.styleFrom(
                 backgroundColor: Theme.of(context).colorScheme.primary,
                 foregroundColor: Theme.of(context).colorScheme.onPrimary, 
                   ),
                 onPressed: () {
                // Navigate to the edit screen
               },
              ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Info om event:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(event.description),
                  const SizedBox(height: 16),
                  Text('Plats/Karta: ${event.location}'),
                  Text('Tid: ${event.dateTime}'),
                  Text('Kontakta arrangör på: ${event.getOwnerEmail}'),
                  Text('Max antal anmälda: ${event.maxAttendees}'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // registerParticipation(currentUserId, widget.eventId);
              },
              child: const Text('Anmäl dig till eventet'),
            ),
          ],
        ),
      ),
    );
  }
}

