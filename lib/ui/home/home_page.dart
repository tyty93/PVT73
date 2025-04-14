import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/home/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          title, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
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
    );
  }
}
