// lib/bloc/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AppStarted>((event, emit) {
      authRepository.user.listen((user) {
        add(user != null ? _UserAuthenticated(user) : _UserSignedOut());
      });
    });

    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signIn(event.email, event.password);
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signUp(event.email, event.password);
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AnonymousSignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signInAnonymously();
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignOutRequested>((event, emit) async {
      await authRepository.signOut();
    });

    // Internal events
    on<_UserAuthenticated>((event, emit) => emit(Authenticated(event.user)));
    on<_UserSignedOut>((event, emit) => emit(Unauthenticated()));
  }
}

// Internal-only events
class _UserAuthenticated extends AuthEvent {
  final AuthUser user;
  _UserAuthenticated(this.user);
  @override
  List<Object?> get props => [user];
}

class _UserSignedOut extends AuthEvent {}
