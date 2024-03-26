import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Note {
  final String _collectionReference = 'notes';

  String? id;
  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? folderId; // Optional field for referencing the folder
  final String? password;

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.folderId,
    this.password,
  });

  factory Note.fromJson(Map<String, dynamic> json, String noteId) {
    return Note(
      id: noteId,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: (json['updated_at'] as Timestamp).toDate(),
      folderId: json['folderId'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Note copyWith(String? title, String? content, DateTime updatedAt) {
    return Note(
        id: this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        createdAt: this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (content != null) "content": content,
      if (createdAt != null) "created_at": createdAt,
      if (updatedAt != null) "updated_at": updatedAt,
      if (folderId != null) "folderId": folderId,
      if (password != null) "password": password,
    };
  }

  String formatDate(dateValue) {
    final formatter = DateFormat('MMMM d, y');
    return formatter.format(dateValue);
  }
}
