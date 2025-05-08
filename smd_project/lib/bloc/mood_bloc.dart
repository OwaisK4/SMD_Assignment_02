// lib/bloc/mood_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'mood_event.dart';
import 'mood_state.dart';
import '../repositories/mood_repository.dart';
import '../models/mood.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  final MoodRepository repository;

  MoodBloc(this.repository) : super(MoodLoading()) {
    on<LoadMoods>((event, emit) {
      emit(MoodLoading());
      repository.getMoods().listen((moods) {
        add(_MoodsUpdated(moods));
      });
    });

    on<AddMood>((event, emit) async {
      await repository.addMood(event.value);
    });

    on<UpdateMood>((event, emit) async {
      await repository.updateMood(event.mood);
    });

    on<DeleteMood>((event, emit) async {
      await repository.deleteMood(event.id);
    });

    on<_MoodsUpdated>((event, emit) {
      emit(MoodLoaded(event.moods));
    });
  }
}

class _MoodsUpdated extends MoodEvent {
  final List<Mood> moods;
  _MoodsUpdated(this.moods);
  @override
  List<Object?> get props => [moods];
}
