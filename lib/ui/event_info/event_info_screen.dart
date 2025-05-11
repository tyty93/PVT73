import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'event_info_viewmodel.dart';
import '../../data/repositories/event_info_repository.dart';

class EventInfoScreen extends StatefulWidget {
  final int eventId;

  const EventInfoScreen({super.key, required this.eventId});

  @override
  State<EventInfoScreen> createState() => _EventInfoScreenState();
}

class _EventInfoScreenState extends State<EventInfoScreen> {
  late Future<void> _initFuture;

  @override
  void initState() {
  super.initState();

  WidgetsBinding.instance.addPostFrameCallback((_) {
    final viewModel = Provider.of<EventInfoViewModel>(context, listen: false);
    _initFuture = viewModel.loadEventInfo(widget.eventId);
    setState(() {}); // Triggers rebuild so FutureBuilder picks up the new future
  });
} 

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EventInfoViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Event Info')),
      body: FutureBuilder<void>(
        future: _initFuture,
        builder: (context, snapshot) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewModel.error != null) {
            return Center(child: Text('Error: ${viewModel.error}'));
          } else if (viewModel.eventinfo == null) {
            return const Center(child: Text("Event not found"));
          }

          final eventinfo = viewModel.eventinfo!;

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
                      Text(eventinfo.name ?? 'No name',
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
                      Text(eventinfo.description ?? 'no description'),
                      const SizedBox(height: 16),
                      Text('Plats/Karta: ${eventinfo.location}'),
                      Text('Tid: ${eventinfo.dateTime}'),
                      Text('Kontakta arrangör på: ${eventinfo.ownerEmail ?? 'placeholder@email.com'}'),
                      Text('Max antal anmälda: ${eventinfo.maxAttendees}'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    // registerParticipation(...)
                  },
                  child: const Text('Anmäl dig till eventet'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
