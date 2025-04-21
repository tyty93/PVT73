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
      //bottomNavigationBar: NavigationBar?
    );
  }
}
