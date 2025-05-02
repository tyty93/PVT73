import 'package:flutter/material.dart';
import 'package:flutter_application_1/routing/layout_scaffold.dart';
import 'package:flutter_application_1/routing/routes.dart';
import 'package:flutter_application_1/ui/event/event_page.dart';
import 'package:go_router/go_router.dart';

import '../ui/auth/viewmodels/auth_viewmodel.dart';
import '../ui/auth/widgets/auth_page.dart';
import '../ui/home/home_page.dart';
// TODO: add navigatorkeys for each branch, try NoTransitionPages, refactor GoRouter instance into singleton DI with  provider to avoid rebuild on hot reload
// see https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter/ for more info
// TODO: test if android back button works on deeper nested pages within any bottomnavbr item's branch.
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

// Use StatefulShellRoute for bottom navigation bar, which will show a UI shell
// wrapping the main content and preventing the navbar from rebuilding each time we navigate to new page
GoRouter createRouter(AuthViewmodel authViewmodel) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.homePage,
    refreshListenable: authViewmodel,
    redirect: (context, state) {
      final isLoggedIn = authViewmodel.isLoggedIn;
      final goingToAuthPage = state.matchedLocation == Routes.authPage;

      if (!isLoggedIn && !goingToAuthPage) return Routes.authPage;
      if (isLoggedIn && goingToAuthPage) return Routes.homePage;
      return null; // No redirection
    },
    routes: [
      GoRoute(
        path: Routes.authPage,
        builder: (context, state) => const AuthPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => LayoutScaffoldWithNavBar(
          navigationShell: navigationShell,
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.homePage,
                builder: (context, state) => const HomePage(),
              )
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.eventsPage,
                builder: (context, state) => const EventPage(),
              )
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.profilePage,
                builder: (context, state) => const Placeholder(),
              )
            ],
          ),
        ], // state is current route state
      ),
    ],
  );
}
