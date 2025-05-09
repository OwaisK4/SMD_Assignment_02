// lib/pages/auth_wrapper.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import 'home_page.dart';
import 'login_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (_, state) {
        if (state is Authenticated) {
          return HomePage(user: state.user);
        }
        // if (state is Authenticated) return HomePage(user: state.user);
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return const LoginPage();
      },
    );
  }
}
