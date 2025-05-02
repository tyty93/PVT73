import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routing/router.dart';
import 'package:flutter_application_1/ui/auth/viewmodels/auth_viewmodel.dart';
import 'package:flutter_application_1/ui/auth/viewmodels/login_or_register_viewmodel.dart';
import 'package:flutter_application_1/ui/common/theme/theme.dart';
import 'package:flutter_application_1/ui/event/event_page_viewmodel.dart';
import 'package:flutter_application_1/ui/home/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

import 'data/repositories/auth_repository.dart';
import 'data/repositories/event_repository.dart';
import 'data/services/auth_service.dart';
import 'firebase_options.dart';

// TODO: Inject GoRouter instead of having a function called in MyApp.build that recreates the instance on rebuilds
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        // Provide AuthService
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        // Inject AuthService into AuthRepositoryImpl
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(context.read<AuthService>()),
        ),
        Provider<EventRepository>(
          create: (context) => EventRepositoryImpl(),
        ),
        // Inject AuthRepository into both ViewModels
        ChangeNotifierProvider(
          create: (context) => AuthViewmodel(authRepository: context.read<AuthRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) => LoginOrRegisterViewmodel(authRepository: context.read<AuthRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewmodel(authRepository: context.read<AuthRepository>()),
        ),
        ChangeNotifierProvider(
          create: (context) => EventsViewmodel(eventRepository: context.read<EventRepository>()),
        ),
      ],
    child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewmodel = context.watch<AuthViewmodel>();
    final router = createRouter(authViewmodel);
    return MaterialApp.router(
        title: 'The App',
        routerConfig: router,
        themeMode: ThemeMode.system,
        theme: MaterialTheme.lightTheme,
        darkTheme: MaterialTheme.darkTheme,
    );
  }
}
