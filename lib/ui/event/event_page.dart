import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/event/event_page_viewmodel.dart';
import 'package:provider/provider.dart';

import 'event_listview.dart';

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
          if (viewModel.events == null) {
            viewModel.loadEvents(); // caution: can get called multiple times without guard
          }
          return EventListview(events: viewModel.events);
        }
      ),
    );
  }
}
