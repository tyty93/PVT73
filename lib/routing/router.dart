import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/models/user.dart';
import 'package:flutter_application_1/routing/layout_scaffold.dart';
import 'package:flutter_application_1/routing/routes.dart';
import 'package:flutter_application_1/ui/event/event_page.dart';
import 'package:flutter_application_1/ui/friends/friends_page/friends_page.dart';
import 'package:flutter_application_1/ui/friends/search_page/friends_search_page.dart';
import 'package:flutter_application_1/ui/friends/user_info_page/user_info_page.dart';
import 'package:flutter_application_1/ui/profile/profile_settings_page.dart';
import 'package:go_router/go_router.dart';
import '../data/models/event.dart';
import '../ui/auth/viewmodels/auth_viewmodel.dart';
import '../ui/auth/widgets/auth_page.dart';
import '../ui/home/create_event.dart';
import '../ui/event_info/event_info_page.dart';
import '../ui/home/home_page.dart';

import 'package:flutter_application_1/ui/map/map_page.dart';
// Shaared detail sreens from multiple tabs? see https://dev.to/7twilight/mastering-nested-navigation-in-flutter-with-gorouter-and-a-bottom-nav-bar-555l
// see https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter/ for more info
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final _shellNavigatorCKey = GlobalKey<NavigatorState>(debugLabel: 'shellC');
final _shellNavigatorDKey = GlobalKey<NavigatorState>(debugLabel: 'shellD');

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
          /// Home Page branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAKey,
            routes: [
              GoRoute(
                path: Routes.homePage,
                builder: (context, state) => const HomePage(),
                routes: [
                  GoRoute( // todo: understand why this is working even from EventPage?
                    path: Routes.eventDetailPath,
                    pageBuilder:  (context, state) {
                      print("Navigating to details: ${state.matchedLocation}");
                      final event = state.extra as Event;
                      return NoTransitionPage(child: EventInfoPage(event: event));
                    }
                  ),
                  GoRoute(
                    path: Routes.create,
                    pageBuilder: (context, state) {
                      print("Navigating to create event: ${state.matchedLocation}");
                      return NoTransitionPage(child: CreateEvent());
                    }
                  ),
                ],
              )
            ],
          ),
          /// Event Page branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorBKey,
            routes: [
              GoRoute(
                path: Routes.eventsPage,
                builder: (context, state) => const EventPage(),
              )
            ],
          ),
          // Map Page branch
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Routes.mapPage,
                builder: (context, state) => const MapPage(),
              )
            ],
          ),
          // Friends Page branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDKey,
            routes: [
              GoRoute(
                path: Routes.friendPage,
                builder: (context, state) => const FriendPageScreen(),
                routes: [
                  GoRoute(
                    path: Routes.userInfoPath,
                    pageBuilder:  (context, state) {
                      log("Navigating to userInfo: ${state.matchedLocation}");
                      final user = state.extra as User;
                      return NoTransitionPage(child: UserInfoPage(user: user));
                    }
                  ),
                  GoRoute(
                    path: Routes.searchPath,
                    pageBuilder: (context, state) {
                      log("Navigating to userInfo: ${state.matchedLocation}");
                      return NoTransitionPage(child: FriendsSearchPage());
                    }
                  )
                ]
              )
            ]
          ),
          /// Profile Page branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorCKey,
            routes: [
              GoRoute(
                path: Routes.profilePage,
                builder: (context, state) => const EditProfileScreen(email: '', userName: '',),
              )
            ],
          ),
        ], // state is current route state
      ),
    ],
  );
}
