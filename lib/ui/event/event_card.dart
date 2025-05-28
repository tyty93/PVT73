import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/models/event.dart';
import 'package:provider/provider.dart';
import 'event_page_viewmodel.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final int index;

  const EventCard({
    super.key,
    required this.event,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card.filled(
        color: index.isEven
            ? Theme.of(context).colorScheme.surfaceContainerHigh
            : Theme.of(context).colorScheme.surfaceContainer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: const CircleAvatar(), // Placeholder
              title: Text(event.name),
              subtitle: Text(event.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Info icon for navigation
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () {
                      final eventId = event.eventId;
                      context.push('/home/event/$eventId', extra: event);
                    },
                  ),

                  Consumer<EventsViewmodel>(
                    builder: (context, viewmodel, child) {
                      final alreadyRegistered = viewmodel.isAlreadyRegisteredTo(event);

                      return IconButton(
                        icon: Icon(
                          alreadyRegistered ? Icons.event_busy : Icons.event_available,
                        ),
                        color: alreadyRegistered
                            ? Theme.of(context).colorScheme.errorContainer
                            : null,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                alreadyRegistered
                                    ? 'Vill du avregistrera dig från eventet?'
                                    : 'Vill du registrera dig till eventet?',
                                textAlign: TextAlign.center,
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                        onPressed: () => Navigator.pop(context, false),
                                        child: const Text('Nej'),
                                      ),
                                    ),
                                    Consumer<EventsViewmodel>(
                                      builder: (context, viewModel, child) => Align(
                                        alignment: Alignment.bottomLeft,
                                        child: TextButton(
                                          onPressed: () async {
                                            if (alreadyRegistered) {
                                              await viewModel.unregisterFromEvent(event);
                                            } else {
                                              await viewModel.registerToEvent(event);
                                            }
                                            if(context.mounted) {
                                              context.pop();
                                            }
                                          },
                                          child: const Text('Ja'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
