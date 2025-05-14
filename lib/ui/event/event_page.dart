import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/event/event_page_viewmodel.dart';
import 'package:provider/provider.dart';
import 'event_card.dart';

/* Should show all events available to sign up for. By clicking an event, go to EventInfo which should have a register button */
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
          return RefreshIndicator(
            onRefresh: viewModel.refreshEvents,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return EventCard(
                    event: events[index],
                    index: index,
                  );
              },
              itemCount: events.length
            ),
          );
        }
      ),
    );
  }
}

