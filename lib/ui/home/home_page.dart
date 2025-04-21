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
          return ListView.separated(
              padding: EdgeInsets.all(8),
              itemCount: viewModel.events.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 40,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child:  Center(child: Text(viewModel.events[index].name)),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(
                height: 20,
              )
          );
        },
      )
      //bottomNavigationBar: , NavigationBar https://www.youtube.com/watch?v=DVGYddFaLv0&t=18s
    );
  }
}
