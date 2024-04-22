import 'package:flutter/foundation.dart';
import 'package:notecraft/services/notes_service.dart';

class NoteProvider extends ChangeNotifier {
  List notes = [];

  bool hasData = false;


  Future fetchNotesData() async {
    NotesService notesService = NotesService();
    await notesService.getNotesStream().then((querySnapshot) {
      for (var docSnapshot in querySnapshot.docs) {
        notes.add(docSnapshot.data());
      }
    });
    notifyListeners();
  } 

}
