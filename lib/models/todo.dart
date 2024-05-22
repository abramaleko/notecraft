import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String _collectionReference = 'todos';

  String? id;
  String task;
  bool completed;
  DateTime? reminder;

  Todo({this.id, required this.task, this.reminder, required this.completed});

  factory Todo.fromJson(Map<String, dynamic> json, String todoId) {
    return Todo(
      id: todoId,
      task: json['task'],
      completed: json['completed'],
      reminder: json['reminder'] != null
          ? (json['reminder'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (task != null) "task": task,
      if (completed != null) "completed": completed,
      if (reminder != null) "reminder": reminder,
    };
  }

    Todo copyWith({required bool completedValue}) {
    return Todo(
        id: this.id,
        task: this.task,
        reminder: reminder,
        completed: completedValue,);
  }
}
