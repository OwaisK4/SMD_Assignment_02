// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/mood_repository.dart';
import '../repositories/note_repository.dart';
import '../bloc/mood_bloc.dart';
import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import "mood_page.dart";
import "notes_page.dart";

class MainPage extends StatelessWidget {
  final NoteRepository repository = NoteRepository();

  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (_) => NoteBloc(repository)..add(LoadNotes()),
        child: NotesPage(),
      ),
      floatingActionButton: Builder(
        builder:
            (context) => FloatingActionButton(
              child: Icon(Icons.emoji_emotions),
              onPressed:
                  () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (context) => BlocProvider(
                            create: (context) => MoodBloc(MoodRepository()),
                            child: const MoodPage(),
                          ),
                    ),
                  ),
            ),
      ),
    );
  }
}
