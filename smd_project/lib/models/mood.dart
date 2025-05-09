// lib/models/mood.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Mood {
  final String id;
  final String value;
  final Timestamp created_at;

  Mood({required this.id, required this.value, required this.created_at});

  Map<String, dynamic> toMap() => {'value': value, 'created_at': created_at};

  factory Mood.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Mood(
      id: doc.id,
      value: data['value'] ?? '',
      created_at:
          data.containsKey('created_at') && data['created_at'] is Timestamp
              ? data['created_at']
              : Timestamp.now(),
    );
  }
}
