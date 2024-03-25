import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notecraft/models/note.dart';

class NotesService {
  final CollectionReference notesCollection = FirebaseFirestore.instance
      .collection('notes')
      .withConverter<Note>(
          fromFirestore: (snapshot, options) => Note.fromJson(snapshot.data()!),
          toFirestore: (Note note, _) => note.toFirestore());

  Stream<QuerySnapshot> getNotesStream() {
    return notesCollection.orderBy("created_at", descending: true).snapshots();
  }

  void addNotes(Note note) async {
    notesCollection.add(note);
  }
}
