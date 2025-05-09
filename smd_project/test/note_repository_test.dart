// test/note_repository_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:your_project/repositories/note_repository.dart';
import 'package:your_project/models/note.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}

void main() {
  late MockCollectionReference mockCollection;
  late NoteRepository noteRepository;

  setUp(() {
    mockCollection = MockCollectionReference();
    noteRepository = NoteRepository()..notesRef = mockCollection; // see below for class change
  });

  test('addNote calls Firestore add method with correct data', () async {
    when(mockCollection.add(any)).thenAnswer((_) async => MockDocumentReference());

    await noteRepository.addNote('New Note');

    verify(mockCollection.add(argThat(containsPair('title', 'New Note')))).called(1);
  });

  test('updateNote calls update on the correct document', () async {
    final mockDoc = MockDocumentReference();
    final note = Note(id: '123', title: 'Updated Title');
    when(mockCollection.doc(note.id)).thenReturn(mockDoc);

    await noteRepository.updateNote(note);

    verify(mockDoc.update({'title': 'Updated Title'})).called(1);
  });

  test('deleteNote calls delete on the correct document', () async {
    final mockDoc = MockDocumentReference();
    when(mockCollection.doc('123')).thenReturn(mockDoc);

    await noteRepository.deleteNote('123');

    verify(mockDoc.delete()).called(1);
  });
}
