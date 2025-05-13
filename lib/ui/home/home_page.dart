import 'package:flutter/material.dart';
import 'package:flutter_application_1/routing/routes.dart';
import 'package:flutter_application_1/ui/home/home_page_viewmodel.dart';
import 'package:go_router/go_router.dart';
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
            return RefreshIndicator(
              onRefresh: viewModel.refreshOwnedEvents,
              child: ListView.builder(
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
              ),
            );
          }
      ),
      floatingActionButton: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.inversePrimary,
              Theme.of(context).colorScheme.onPrimary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,
          onPressed: () {
            context.push('/home/create-event');
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
