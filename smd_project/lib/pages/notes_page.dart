import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../bloc/note_state.dart';

class NotesPage extends StatelessWidget {
  NotesPage({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NoteBloc>();

    return Scaffold(
      appBar: AppBar(title: Text("Notes")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(child: TextField(controller: controller)),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    bloc.add(AddNote(controller.text));
                    controller.clear();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<NoteBloc, NoteState>(
              builder: (context, state) {
                if (state is NoteLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is NoteLoaded) {
                  return ListView.builder(
                    itemCount: state.notes.length,
                    itemBuilder: (_, i) {
                      final note = state.notes[i];
                      return ListTile(
                        title: Text(note.title),
                        subtitle: Text(
                          note.created_at.toDate().toIso8601String(),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => bloc.add(DeleteNote(note.id)),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("Error"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
