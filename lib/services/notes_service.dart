import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notecraft/models/note.dart';
import 'package:notecraft/provider/note_provider.dart';

class NotesService {
  final CollectionReference notesCollection = FirebaseFirestore.instance
      .collection('notes')
      .withConverter<Note>(
          fromFirestore: (snapshot, options) =>
              Note.fromJson(snapshot.data()!, snapshot.id),
          toFirestore: (Note note, _) => note.toFirestore());

  Future<QuerySnapshot> getNotesStream() async {
    return await notesCollection.orderBy("created_at", descending: true).get();
  }

  void addNotes(Note note) async {
    await notesCollection.add(note);
    await NoteProvider().fetchNotesData();
  }

  void updateNote(Note note) async {
    await notesCollection.doc(note.id).update(note.toFirestore());
    NoteProvider().fetchNotesData();
  }
}
