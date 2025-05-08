// lib/bloc/note_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/note_repository.dart';
import '../models/note.dart';
import 'note_event.dart';
import 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository repository;

  NoteBloc(this.repository) : super(NoteLoading()) {
    on<LoadNotes>(_onLoadNotes);
    on<AddNote>(_onAddNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
    on<_NoteDataChanged>(_onNoteDataChanged);
  }

  void _onLoadNotes(LoadNotes event, Emitter<NoteState> emit) {
    emit(NoteLoading());
    repository.getNotes().listen((notes) => add(_NoteDataChanged(notes)));
  }

  void _onAddNote(AddNote event, Emitter<NoteState> emit) async {
    await repository.addNote(event.title);
  }

  void _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) async {
    await repository.updateNote(event.note);
  }

  void _onDeleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    await repository.deleteNote(event.id);
  }

  //   // Private internal event to update state from stream
  void _onNoteDataChanged(_NoteDataChanged event, Emitter<NoteState> emit) {
    emit(NoteLoaded(event.notes));
  }
}

// Internal event
class _NoteDataChanged extends NoteEvent {
  final List<Note> notes;
  _NoteDataChanged(this.notes);
  @override
  List<Object?> get props => [notes];
}
