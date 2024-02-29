import 'package:flutter/material.dart';

Widget NotesCard() {
  return Flexible(
    child: Container(
      width: 190,
      child: const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title text
              Text(
                "Personal Items",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0), // Add spacing between title and content

              // Content text
              Text(
                "New boxers (20K) \nEye glasses (100K) \nTeeth (200K)",
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
              SizedBox(
                  height: 9.0), // Add spacing between content and date/time
              Text(
                "November 19, 2023",
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
