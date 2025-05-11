import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/event/event_page_viewmodel.dart';
import 'package:provider/provider.dart';
import 'event_card.dart';

/* show all events available to sign up for */
class EventPage extends StatelessWidget {
  const EventPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Events"),
      ),
      body: Consumer<EventsViewmodel>(
        builder: (context, viewModel, _) {
          if (viewModel.availableEvents == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.availableEvents!.isEmpty) {
            return Center(child: Text('No events available'));
          }
          final events = viewModel.availableEvents!;
          return ListView.builder(
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.startToEnd,
                confirmDismiss: (direction) {
                  return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Remove the event?'),
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
                  eventName: events[index].name,
                  eventDescription: events[index].description,
                  index: index,
                ),
              );
            },
            itemCount: events.length
          );
        }
      ),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          context.read<EventsViewmodel>().joinEvent(
            ......
          );
        },
      ),*/
    );
  }
}
