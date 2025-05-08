// lib/repositories/note_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';

class NoteRepository {
  final _notesRef = FirebaseFirestore.instance.collection('notes');

  Stream<List<Note>> getNotes() {
    return _notesRef.snapshots().map(
      (snap) => snap.docs.map((doc) => Note.fromDoc(doc)).toList(),
    );
  }

  Future<void> addNote(String title) {
    return _notesRef.add({'title': title});
  }

  Future<void> updateNote(Note note) {
    return _notesRef.doc(note.id).update({'title': note.title});
  }

  Future<void> deleteNote(String id) {
    return _notesRef.doc(id).delete();
  }
}
