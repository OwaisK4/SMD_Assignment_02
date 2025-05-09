// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_event.dart';
import 'repositories/auth_repository.dart';
import 'pages/auth_wrapper.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final authRepository = AuthRepository();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create:
            (_) => AuthBloc(authRepository: authRepository)..add(AppStarted()),
        child: const AuthWrapper(),
      ),
    ),
  );
}
