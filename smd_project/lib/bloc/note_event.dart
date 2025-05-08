// lib/bloc/note_event.dart
import 'package:equatable/equatable.dart';
import '../models/note.dart';

abstract class NoteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final String title;

  AddNote(this.title);

  @override
  List<Object?> get props => [title];
}

class UpdateNote extends NoteEvent {
  final Note note;

  UpdateNote(this.note);

  @override
  List<Object?> get props => [note];
}

class DeleteNote extends NoteEvent {
  final String id;

  DeleteNote(this.id);

  @override
  List<Object?> get props => [id];
}
