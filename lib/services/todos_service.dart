import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:notecraft/models/todo.dart';

class TodosService {
  List todos = [];

  final CollectionReference todosCollection = FirebaseFirestore.instance
      .collection('todos')
      .withConverter<Todo>(
          fromFirestore: (snapshot, options) =>
              Todo.fromJson(snapshot.data()!, snapshot.id),
          toFirestore: (Todo todo, _) => todo.toFirestore());

  Stream<QuerySnapshot> getTodosStream() {
    return todosCollection.snapshots();
  }

  void addTask(Todo todo) async {
    todosCollection.add(todo);
  }

  // void updateNote(Note note) async {
  //   notesCollection.doc(note.id).update(note.toFirestore());
  // }
}
