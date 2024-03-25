import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notecraft/models/note.dart';

class NotesService {
  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('notes');

  Stream<QuerySnapshot> getNotesStream() {
    return notesCollection.snapshots();
  }
}
