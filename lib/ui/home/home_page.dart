import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/home/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

import '../event/event_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  final String title = "The app";
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
            if (viewModel.ownedEvents == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (viewModel.ownedEvents!.isEmpty) {
              return Center(child: Text('(placeholder text): You have not created any events.'));
            }
            final events = viewModel.ownedEvents!;
            return ListView.builder(
                itemBuilder: (context, index) {
                  return Dismissible(
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
                      viewModel.deleteEvent(events[index]);
                    },
                    key: ValueKey<int>(events[index].eventId),
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
                    child: EventCard(
                      event: events[index],
                      index: index,
                    ),
                  );
                },
                itemCount: events.length
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // todo: don't hardcode, these values are for testing. the FAB should initiate a create flow with texteditingcontrollers and nested navigation in gorouter
          context.read<HomeViewmodel>().createEvent(
            name: "Other event",
            description: "Lets swim",
            theme: "Sport",
            location: "Swimcenter",
            maxAttendees: 100,
            dateTime: DateTime.now().add(Duration(days: 1)),
          ); // calling function (without rebuilding for now)
        },
      ),
    );
  }
}
