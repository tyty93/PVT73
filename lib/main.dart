import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/repositories/friend_repository.dart';
import 'package:flutter_application_1/data/repositories/search_repository.dart';
import 'package:flutter_application_1/ui/auth/viewmodels/auth_viewmodel.dart';
import 'package:flutter_application_1/ui/auth/viewmodels/login_or_register_viewmodel.dart';
import 'package:flutter_application_1/ui/auth/widgets/auth_page.dart';
import 'package:flutter_application_1/ui/common/theme/theme.dart';
import 'package:flutter_application_1/ui/friends/friends_page/friends_page_viewmodel.dart';
import 'package:flutter_application_1/ui/friends/search_page/friends_search_page.dart';
import 'package:flutter_application_1/ui/friends/search_page/friends_search_page_viewmodel.dart';
import 'package:flutter_application_1/ui/home/home_page_viewmodel.dart';
import 'package:provider/provider.dart';

import 'data/repositories/auth_repository.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The App',
      home: MultiProvider(
        providers: [
          Provider<AuthRepository>(
            create: (_) => AuthRepository()
          ),
          Provider<FriendRepository>(
            create: (context) => FriendRepositoryImpl()
          ),
          Provider<SearchRepository>(
            create: (context) => SearchRepositoryImpl()
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
              create: (context) => FriendsPageViewmodel(friendRepository: context.read<FriendRepository>()),
          ),
          ChangeNotifierProvider(
              create: (context) => FriendsSearchPageViewmodel(searchRepository: context.read<SearchRepository>()),
          )
        ],
        child: const AuthPage(),
      ),
      themeMode: ThemeMode.system,
      theme: MaterialTheme.lightTheme,
      darkTheme: MaterialTheme.darkTheme,
    );
  }
}
