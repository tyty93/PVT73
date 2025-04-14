import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/auth/widgets/register_page.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_or_register_viewmodel.dart';
import 'login_page.dart';
class LoginOrRegisterPage extends StatelessWidget {
  const LoginOrRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginOrRegisterViewmodel>(
      builder: (context, viewModel, _) {
        return viewModel.showLoginPage
            ? const LoginPage()
            : const RegisterPage();
      },
    );
  }
}
