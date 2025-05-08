// lib/repositories/mood_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/mood.dart';

class MoodRepository {
  final _moodsRef = FirebaseFirestore.instance.collection('mood');

  Stream<List<Mood>> getMoods() {
    return _moodsRef.snapshots().map(
      (snap) => snap.docs.map((doc) => Mood.fromDoc(doc)).toList(),
    );
  }

  Future<void> addMood(String value) {
    return _moodsRef.add({
      'value': value,
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateMood(Mood mood) {
    return _moodsRef.doc(mood.id).update({'value': mood.value});
  }

  Future<void> deleteMood(String id) {
    return _moodsRef.doc(id).delete();
  }
}
