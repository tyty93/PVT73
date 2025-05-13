// Source code is combination of two:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
// and https://www.youtube.com/watch?v=S8juKcQRyNI

import 'package:flutter/material.dart';
import 'package:flutter_application_1/routing/destination.dart';
import 'package:go_router/go_router.dart';

/// Builds the "shell" for the app by building a Scaffold with a
/// NavigationBar, where [child] is placed in the body of the Scaffold.
class LayoutScaffoldWithNavBar extends StatelessWidget {
  const LayoutScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
          destinations: navigationDestinations,
      ),
    );
  }
}