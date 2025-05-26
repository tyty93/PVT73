import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/friend_repository.dart';
import 'package:flutter_application_1/data/services/friend_service.dart';
import 'package:flutter_application_1/data/services/user_service.dart';
import 'package:flutter_application_1/routing/router.dart';
import 'package:flutter_application_1/ui/auth/viewmodels/auth_viewmodel.dart';
import 'package:flutter_application_1/ui/auth/viewmodels/login_or_register_viewmodel.dart';
import 'package:flutter_application_1/ui/common/theme/theme.dart';
import 'package:flutter_application_1/ui/event/event_page_viewmodel.dart';
import 'package:flutter_application_1/ui/friends/friends_page/friends_page_viewmodel.dart';
import 'package:flutter_application_1/ui/friends/search_page/friends_search_page_viewmodel.dart';
import 'package:flutter_application_1/ui/home/home_page_viewmodel.dart';
import 'package:flutter_application_1/ui/map/map_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'data/repositories/auth_repository.dart';
import 'data/repositories/event_repository.dart';
import 'data/repositories/user_repository.dart';
import 'data/services/auth_service.dart';
import 'data/services/event_service.dart';
import 'firebase_options.dart';
import 'ui/event_info/event_info_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        // Provide services
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<UserService>(
          create: (_) => UserService(),
        ),
        Provider<EventService>(
          create: (_) => EventService(),
        ),
        Provider<FriendService>(
          create: (_) => FriendService(),
        ),

        // Provide repositories
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(context.read<AuthService>(), context.read<UserService>()),
        ),
        Provider<EventRepository>(
          create: (context) => EventRepositoryImpl(context.read<AuthService>(), context.read<EventService>()),
        ),
        Provider<UserRepository>(
          create: (context) => UserRepositoryImpl(context.read<UserService>(), context.read<AuthService>()),
        ),
        Provider<FriendRepository>(
          create: (context) => FriendRepositoryImpl(context.read<FriendService>(), context.read<AuthService>()),
        ),

        // Inject into Viewmodels
        ChangeNotifierProvider(
          create: (context) => AuthViewmodel(authRepository: context.read<AuthRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginOrRegisterViewmodel(authRepository: context.read<AuthRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewmodel(
            authRepository: context.read<AuthRepository>(),
            userRepository: context.read<UserRepository>(),
            eventRepository: context.read<EventRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => EventsViewmodel(eventRepository: context.read<EventRepository>(), userRepository: context.read<UserRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) => FriendsPageViewmodel(userRepository: context.read<FriendRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) => FriendsSearchPageViewmodel(userRepository: context.read<FriendRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) => MapViewModel(eventRepository: context.read<EventRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) => EventInfoViewModel(eventRepository: context.read<EventRepository>()),
        ),

        // Router
        Provider<GoRouter>(
          lazy: false,
          create: (context) => createRouter(context.read<AuthViewmodel>()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = context.read<GoRouter>();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'The App',
      routerConfig: router,
      themeMode: ThemeMode.system,
      theme: MaterialTheme.lightTheme,
      darkTheme: MaterialTheme.darkTheme,
    );
  }
}
