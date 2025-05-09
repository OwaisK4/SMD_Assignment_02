import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  final String title;
  final Timestamp created_at;

  Note({required this.id, required this.title, required this.created_at});

  Map<String, dynamic> toMap() {
    return {'title': title, 'created_at': created_at};
  }

  factory Note.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Note(
      id: doc.id,
      title: data['title'] ?? '',
      created_at:
          data.containsKey('created_at') && data['created_at'] is Timestamp
              ? data['created_at']
              : Timestamp.now(),
    );
  }
}
