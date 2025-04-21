import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../common/custom_button.dart';
import '../../common/custom_textfield.dart';
import '../viewmodels/login_or_register_viewmodel.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Image.asset(
                'assets/logo.png',
                height: 100,
              ),

              const SizedBox(height: 20),

              // app name
              const Text("AfterTenta"),
              const SizedBox(height: 20),

              // email textfield
              CustomTextField(hintText: "Email", obscureText: false, controller: emailController),
              const SizedBox(height: 20),

              // password textfield
              CustomTextField(hintText: "Password", obscureText: true, controller: passwordController),
              const SizedBox(height: 20),

              // log in button
              Consumer<LoginOrRegisterViewmodel>(
                builder: (context, viewModel, _) {
                  return Column(
                    children: [
                      if (viewModel.isLoading)
                        const CircularProgressIndicator(),

                      if (viewModel.errorMessage != null)
                        Text(viewModel.errorMessage!, style: TextStyle(color: Theme.of(context).colorScheme.error)),

                      CustomButton(
                          text: "Login",
                          onTap: () => viewModel.signInWithEmailAndPassword(emailController.text, passwordController.text)
                      ),
                    ],
                  );
                  },
              ),
              const SizedBox(height: 20),

              // register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  Consumer<LoginOrRegisterViewmodel>(
                    builder: (context, viewModel, _) {
                      return GestureDetector(
                        onTap: viewModel.togglePages,
                        child: const Text(
                          " Register here",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // sign in with google
              Consumer<LoginOrRegisterViewmodel>(
                builder: (context, viewModel, _) {
                  return SignInButton(
                    Buttons.google,
                    text: "Sign in with Google",
                    onPressed: () => viewModel.signInWithGoogle(),
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}