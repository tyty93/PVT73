import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/home/create_event.dart';
import 'package:flutter_application_1/ui/home/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

import '../event/event_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final String title = "AfterTenta";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          // Sign out button
          Consumer<HomeViewmodel>(
            builder: (context, viewModel, _) {
              return IconButton(
                onPressed: viewModel.signOut,
                icon: const Icon(Icons.logout),
              );
            },
          ),
        ],
      ),
      body: Consumer<HomeViewmodel>(
        builder: (context, viewModel, _) {
          final ownedEvents = viewModel.ownedEvents;
          final registeredEvents = viewModel.participatingInEvents;

          if (ownedEvents == null || registeredEvents == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: viewModel.refreshAllEvents,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Ägda Events",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ...ownedEvents.map((event) => Dismissible(
                      direction: DismissDirection.startToEnd,
                      confirmDismiss: (direction) {
                        return showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Cancel the event?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Yes'),
                              ),
                            ],
                          ),
                        );
                      },
                      onDismissed: (direction) {
                        viewModel.deleteEvent(event);
                      },
                      key: ValueKey<int>(event.eventId),
                      background: Container(
                        padding: const EdgeInsets.all(12),
                        color: Theme.of(context).colorScheme.errorContainer,
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.onErrorContainer,
                          size: 40,
                        ),
                      ),
                      child: EventCard(event: event, index: ownedEvents.indexOf(event)),
                    )),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    "Events du ska gå på",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                ...registeredEvents.map((event) =>
                    EventCard(event: event, index: registeredEvents.indexOf(event))),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.inversePrimary,
              Theme.of(context).colorScheme.primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateEvent()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
