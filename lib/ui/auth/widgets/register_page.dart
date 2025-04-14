import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/custom_button.dart';
import '../../common/custom_textfield.dart';
import '../viewmodels/login_or_register_viewmodel.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPwController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(
                Icons.person,
                size: 70,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),

              const SizedBox(height: 20),

              // app name
              const Text("Weather app"),
              const SizedBox(height: 20),

              // username textfield
              CustomTextField(hintText: "Username", obscureText: false, controller: usernameController),
              const SizedBox(height: 20),

              // email textfield
              CustomTextField(hintText: "Email", obscureText: false, controller: emailController),
              const SizedBox(height: 20),

              // password textfield
              CustomTextField(hintText: "Password", obscureText: true, controller: passwordController),
              const SizedBox(height: 20),

              // confirm password textfield
              CustomTextField(hintText: "Confirm password", obscureText: true, controller: confirmPwController),
              const SizedBox(height: 20),

              // register button
              Consumer<LoginOrRegisterViewmodel>(
                builder: (context, viewModel, _) {
                  return Column(
                    children: [
                      if (viewModel.isLoading)
                        const CircularProgressIndicator(),

                      if (viewModel.errorMessage != null)
                        Text(viewModel.errorMessage!, style: TextStyle(color: Theme.of(context).colorScheme.error)),

                      CustomButton(
                        text: "Register",
                        onTap: () => viewModel.signUpWithEmailAndPassword(emailController.text, passwordController.text, confirmPwController.text)
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
                  Text("Already have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Consumer<LoginOrRegisterViewmodel>(
                    builder: (context, viewModel, _) {
                      return GestureDetector(
                        onTap: viewModel.togglePages,
                        child: const Text(
                          " Login here",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}