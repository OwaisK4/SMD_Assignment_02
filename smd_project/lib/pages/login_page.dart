// lib/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final bloc = context.read<AuthBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed:
                  () => bloc.add(
                    SignInRequested(
                      emailController.text,
                      passwordController.text,
                    ),
                  ),
              child: const Text("Login"),
            ),
            ElevatedButton(
              onPressed:
                  () => bloc.add(
                    SignUpRequested(
                      emailController.text,
                      passwordController.text,
                    ),
                  ),
              child: const Text("Register"),
            ),
            TextButton(
              onPressed: () => bloc.add(AnonymousSignInRequested()),
              child: const Text("Continue as Guest"),
            ),
          ],
        ),
      ),
    );
  }
}
