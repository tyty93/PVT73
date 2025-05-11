import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/home/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // todo: don't hardcode, these values are for testing. the FAB should initiate a create flow with texteditingcontrollers and nested navigation in gorouter
          context.read<HomeViewmodel>().createEvent(
            name: "Event x",
            description: "Description x",
            theme: "Theme x",
            location: "Location x",
            maxAttendees: 5,
            dateTime: DateTime.now().add(Duration(days: 1)),
          ); // calling function (without rebuilding for now)
        },
      ),
    );
  }
}
