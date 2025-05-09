// lib/bloc/auth_event.dart
import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}

class SignInRequested extends AuthEvent {
  final String email, password;
  SignInRequested(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

class SignUpRequested extends AuthEvent {
  final String email, password;
  SignUpRequested(this.email, this.password);
  @override
  List<Object?> get props => [email, password];
}

class AnonymousSignInRequested extends AuthEvent {}

class SignOutRequested extends AuthEvent {}
