import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event_info_viewmodel.dart';
import '../../data/repositories/event_info_repository.dart';

class EventInfoPage extends StatefulWidget {
  final int eventId;

  const EventInfoPage({super.key, required this.eventId});

  @override
  State<EventInfoPage> createState() => _EventInfoPageState();
}

class _EventInfoPageState extends State<EventInfoPage> {
  late Future<void> _initFuture;

  @override
  void initState() {
    super.initState();

    final viewModel = EventInfoViewModel(eventRepository: EventInfoRepositoryImpl());
    _initFuture = viewModel.loadEventInfo(widget.eventId);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventInfoViewModel>(context, listen: false).loadEventInfo(widget.eventId);
    });
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Event Info')),
    body: FutureBuilder<void>(
      future: _initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final viewModel = Provider.of<EventInfoViewModel>(context);
          final event = viewModel.event;

          if (event == null) {
              return const Center(child: Text("Event not found"));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.purple[200],
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(event.name,
                          style: Theme.of(context).textTheme.headlineMedium),
                      const SizedBox(height: 8),
                      Text('Arrangör: TestOwner'),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.purple[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Info om event:',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(event.description),
                      const SizedBox(height: 16),
                      Text('Plats/Karta: ${event.location}'),
                      Text('Tid: ${event.dateTime}'),
                      //Text('Kontakta arrangör på: example@email.com'),
                      Text('Kontakta arrangör på: ${event.ownerEmail}'),
                      Text('Max antal anmälda: ${event.maxAttendees}'),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                ElevatedButton(
                  onPressed: () {
                     //registerParticipation(currentUserId, widget.eventId);
                  },
                  child: const Text('Anmäl dig till eventet'),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No event found.'));
        }
      },
    ),
  );
}

}