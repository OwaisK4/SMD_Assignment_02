// lib/bloc/mood_state.dart
import 'package:equatable/equatable.dart';
import '../models/mood.dart';

abstract class MoodState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MoodLoading extends MoodState {}

class MoodLoaded extends MoodState {
  final List<Mood> moods;
  MoodLoaded(this.moods);
  @override
  List<Object?> get props => [moods];
}

class MoodError extends MoodState {}
