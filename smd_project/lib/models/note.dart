import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  final String title;

  Note({required this.id, required this.title});

  Map<String, dynamic> toMap() {
    return {'title': title};
  }

  factory Note.fromDoc(DocumentSnapshot doc) {
    return Note(id: doc.id, title: doc['title']);
  }
}
