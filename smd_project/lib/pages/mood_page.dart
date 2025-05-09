// lib/pages/mood_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/mood_bloc.dart';
import '../bloc/mood_event.dart';
import '../bloc/mood_state.dart';
// import '../models/mood.dart';

class MoodPage extends StatefulWidget {
  const MoodPage({super.key});

  @override
  State<MoodPage> createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  String? _selectedMood;

  static const validMoods = ["Happy", "Sad", "Angry"];

  @override
  void initState() {
    super.initState();
    context.read<MoodBloc>().add(LoadMoods());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MoodBloc>();

    return Scaffold(
      appBar: AppBar(title: const Text("Mood Tracker")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: "Select Mood"),
              items:
                  validMoods
                      .map(
                        (mood) =>
                            DropdownMenuItem(value: mood, child: Text(mood)),
                      )
                      .toList(),
              value: _selectedMood,
              onChanged: (value) {
                setState(() => _selectedMood = value);
              },
            ),
          ),
          ElevatedButton(
            onPressed:
                _selectedMood != null
                    ? () {
                      bloc.add(AddMood(_selectedMood!));
                      setState(() => _selectedMood = null);
                    }
                    : null,
            child: const Text("Add Mood"),
          ),
          const SizedBox(height: 10),
          const Divider(),
          Expanded(
            child: BlocBuilder<MoodBloc, MoodState>(
              builder: (context, state) {
                if (state is MoodLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MoodLoaded) {
                  return ListView.builder(
                    itemCount: state.moods.length,
                    itemBuilder: (_, i) {
                      final mood = state.moods[i];
                      return ListTile(
                        title: Text(mood.value),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => bloc.add(DeleteMood(mood.id)),
                        ),
                        subtitle: Text(
                          mood.created_at.toDate().toIso8601String(),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("Failed to load moods."));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
