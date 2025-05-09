// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/mood_repository.dart';
import '../repositories/note_repository.dart';
import '../repositories/auth_repository.dart';
import '../bloc/mood_bloc.dart';
import '../bloc/note_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/note_event.dart';
import '../bloc/auth_event.dart';
import "mood_page.dart";
import "notes_page.dart";

class HomePage extends StatelessWidget {
  final AuthUser user;
  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(SignOutRequested());
            },
          ),
        ],
      ),
      //   body: Center(
      //     child: Text(user.isAnonymous ? "Hello, Guest!" : "Hello, ${user.uid}"),
      //   ),
      body: BlocProvider(
        create: (_) => NoteBloc(NoteRepository())..add(LoadNotes()),
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
