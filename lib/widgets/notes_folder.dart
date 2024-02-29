import 'package:flutter/material.dart';

Widget NotesFolder() {
  return Expanded(
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(
              Icons.folder,
              size: 90,
              color: Colors.orange.shade400,
            ),
            Text(
              'All',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    ),
  );
}
