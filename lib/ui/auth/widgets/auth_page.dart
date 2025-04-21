import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../event/event_page.dart';
import '../../home/home_page.dart';
import '../viewmodels/auth_viewmodel.dart';
import 'login_or_register_page.dart';

/* If user already logged in, want to go directly to home page, else to loginorregister page */
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthViewmodel>(
        builder: (context, viewModel, _) {
          if (viewModel.isLoggedIn) {
            return const EventPage();
          } else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
