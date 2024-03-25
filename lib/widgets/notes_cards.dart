import 'package:flutter/material.dart';
import 'package:notecraft/models/note.dart';

Widget NotesCard(Note note) {
  return Flexible(
    child: Container(
      width: 190,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title text
              Text(
                note.title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 8.0), // Add spacing between title and content

              // Content text
              Text(
                note.content,
                style: TextStyle(
                  fontSize: 13.0,
                ),
                maxLines: 3,
              ),
              SizedBox(
                  height: 9.0), // Add spacing between content and date/time
              Text(
                note.formatDate(note.createdAt),
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
