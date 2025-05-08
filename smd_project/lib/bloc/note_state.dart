// lib/bloc/note_state.dart
import 'package:equatable/equatable.dart';
import '../models/note.dart';

abstract class NoteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final List<Note> notes;

  NoteLoaded(this.notes);

  @override
  List<Object?> get props => [notes];
}

class NoteError extends NoteState {}
