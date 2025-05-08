// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/mood_bloc.dart';
import 'repositories/mood_repository.dart';
import 'bloc/note_bloc.dart';
import 'bloc/note_event.dart';
import 'repositories/note_repository.dart';
// import 'models/note.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import "pages/mood_page.dart";
import "pages/notes_page.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final NoteRepository repository = NoteRepository();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore BLoC',
      home: Scaffold(
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
      ),
    );
  }
}
