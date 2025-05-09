import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:your_project/repositories/auth_repository.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  late MockFirebaseAuth mockAuth;
  late AuthRepository authRepository;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    authRepository = AuthRepository().._firebaseAuth = mockAuth;
  });

  test('signIn calls FirebaseAuth.signInWithEmailAndPassword', () async {
    when(mockAuth.signInWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password')))
        .thenAnswer((_) async => MockUserCredential());

    await authRepository.signIn('test@example.com', 'password');

    verify(mockAuth.signInWithEmailAndPassword(
      email: 'test@example.com',
      password: 'password',
    )).called(1);
  });
}

class MockUserCredential extends Mock implements UserCredential {}
