import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Note {
  final String _collectionReference = 'notes';

  final String title;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String folderId; // Optional field for referencing the folder
  final String password;

  Note({
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.folderId,
    required this.password,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: (json['updated_at'] as Timestamp).toDate(),
      folderId: json['folderId'] ?? '',
      password: json['password'] ?? '',
    );
  }

  String formatDate(dateValue) {
    final formatter = DateFormat('MMMM d, y');
    return formatter.format(dateValue);
  }
}
