// lib/bloc/mood_event.dart
import 'package:equatable/equatable.dart';
import '../models/mood.dart';

abstract class MoodEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMoods extends MoodEvent {}

class AddMood extends MoodEvent {
  final String value;
  AddMood(this.value);
  @override
  List<Object?> get props => [value];
}

class UpdateMood extends MoodEvent {
  final Mood mood;
  UpdateMood(this.mood);
  @override
  List<Object?> get props => [mood];
}

class DeleteMood extends MoodEvent {
  final String id;
  DeleteMood(this.id);
  @override
  List<Object?> get props => [id];
}
