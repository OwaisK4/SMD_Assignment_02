import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:your_project/repositories/mood_repository.dart';
import 'package:your_project/models/mood.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}
class MockQuerySnapshot extends Mock implements QuerySnapshot<Map<String, dynamic>> {}
class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot<Map<String, dynamic>> {}

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollection;
  late MoodRepository moodRepository;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    moodRepository = MoodRepository();
  });

  test('addMood calls Firestore add method', () async {
    when(mockCollection.add(any)).thenAnswer((_) async => MockDocumentReference());
    moodRepository = MoodRepository().._moodsRef = mockCollection;

    await moodRepository.addMood('Happy');

    verify(mockCollection.add(argThat(containsPair('value', 'Happy')))).called(1);
  });
}