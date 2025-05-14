import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:provider/provider.dart';
import '../../friends/friends_page/friends_page.dart';
import '../viewmodels/auth_viewmodel.dart';
=======
>>>>>>> 32298f159d0b87186b0c4726701390f3e75823c8
import 'login_or_register_page.dart';

// todo: refactor by merging with login/register page
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      body: Consumer<AuthViewmodel>(
        builder: (context, viewModel, _) {
          if (viewModel.isLoggedIn) {
            return const FriendPageScreen();
          } else {
            return const LoginOrRegisterPage();
          }
        },
      ),
    );
=======
    return const LoginOrRegisterPage();
>>>>>>> 32298f159d0b87186b0c4726701390f3e75823c8
  }
}
