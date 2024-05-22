import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:notecraft/models/note.dart';
import 'dart:async';

class NotesService {
  List notes = [];

  final CollectionReference notesCollection = FirebaseFirestore.instance
      .collection('notes')
      .withConverter<Note>(
          fromFirestore: (snapshot, options) =>
              Note.fromJson(snapshot.data()!, snapshot.id),
          toFirestore: (Note note, _) => note.toFirestore());

  Stream<QuerySnapshot> getNotesStream() {
    return notesCollection
        .orderBy("pinned", descending: true)
        .orderBy("created_at", descending: true)
        .snapshots();
  }

  void addNotes(Note note) async {
    notesCollection.add(note);
  }

  void updateNote(Note note) async {
    notesCollection.doc(note.id).update(note.toFirestore());
  }
}
