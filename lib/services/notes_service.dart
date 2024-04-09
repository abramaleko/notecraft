import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notecraft/models/note.dart';

class NotesService {
  final CollectionReference notesCollection = FirebaseFirestore.instance
      .collection('notes')
      .withConverter<Note>(
          fromFirestore: (snapshot, options) =>
              Note.fromJson(snapshot.data()!, snapshot.id),
          toFirestore: (Note note, _) => note.toFirestore());

  Future<QuerySnapshot> getNotesStream()async {
    return await notesCollection
        .orderBy("created_at", descending: true).get();
  }

  void addNotes(Note note) async {
    notesCollection.add(note);
  }

  void updateNote(Note note) async {
    notesCollection.doc(note.id).update(note.toFirestore());
  }
}
