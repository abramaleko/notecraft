import 'package:flutter/material.dart';
import 'package:notecraft/models/note.dart';

Widget NotesCard(Note note,context) {
  return Container(
    width: 190,
    child: Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title text
            Text(
              note.title.isNotEmpty
                  ? note.title
                  : note.content.substring(0, 20),
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
            SizedBox(height: 9.0), // Add spacing between content and date/time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  note.formatDate(note.createdAt),
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
               if(note.pinned == true)
                Icon(
                  Icons.push_pin,
                  color: Colors.yellow.shade800,
                  size: 16,
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
