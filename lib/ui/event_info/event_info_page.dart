import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/event.dart';
import 'event_info_viewmodel.dart';
import '../../data/repositories/event_info_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';


// Todo: fix colors (either apply theme colors manually or change from basic Container/Column stuff to more material-like widgets with automaticaally applied pr
class EventInfoPage extends StatefulWidget {
  final Event event;

  const EventInfoPage({super.key, required this.event});

  @override
  State<EventInfoPage> createState() => _EventInfoPageState();
}

class _EventInfoPageState extends State<EventInfoPage> {
  @override
  void initState() {
    super.initState();

    final viewModel = Provider.of<EventInfoViewModel>(context, listen: false);
    viewModel.loadFriendsAttending(widget.event.eventId);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EventInfoViewModel>(context, listen: true);
    final friends = viewModel.friendsAttending;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text('Event ${widget.event.eventId}'),
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
                      widget.event.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 8),
                    Text('Arrangör: ${widget.event.ownerName}'),
                  ],
                ),
              ),
            ),
            if (widget.event.ownerId == FirebaseAuth.instance.currentUser?.uid)
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
                  Text(widget.event.description),
                  const SizedBox(height: 16),
                  Text('Plats/Karta: ${widget.event.location}'),
                  Text('Tid: ${widget.event.dateTime}'),
                  Text('Kontakta arrangör på: ${widget.event.getOwnerEmail}'),
                  Text('Max antal anmälda: ${widget.event.maxAttendees}'),
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
            if (friends.isNotEmpty) ...[
              const SizedBox(height: 16),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Vänner som ska dit:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children: friends.map((friend) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            friend,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
