import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notecraft/services/notes_service.dart';
import 'package:notecraft/widgets/notes_cards.dart';
import 'package:notecraft/widgets/notes_folder.dart';
import 'package:notecraft/models/note.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  int _selectedIndex = 1;
  final NotesService notesService = NotesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: FloatingActionButton(
            elevation: 4.0,
            onPressed: () => context.goNamed('new-note'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(13, 65, 13, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notes',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    },
                    child: Stack(
                      children: [
                        Text(
                          "All",
                          style: TextStyle(
                            color: _selectedIndex == 1
                                ? Theme.of(context).colorScheme.primary
                                : Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (_selectedIndex == 1)
                          Positioned(
                            bottom: 0.0, // Adjust as needed
                            left: 0.0,
                            right: 0.0,
                            top: 20,
                            child: Divider(
                              thickness: 2.0,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                    child: Stack(
                      children: [
                        Text(
                          "Folders",
                          style: TextStyle(
                            color: _selectedIndex == 2
                                ? Theme.of(context).colorScheme.primary
                                : Colors.black,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (_selectedIndex == 2)
                          Positioned(
                            bottom: 0.0, // Adjust as needed
                            left: 0.0,
                            right: 0.0,
                            top: 20,
                            child: Divider(
                              thickness: 2.0,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              if (_selectedIndex == 1)
                StreamBuilder(
                    stream: notesService.getNotesStream(),
                    builder: (context, snapshot) {
                      List notes = snapshot.data?.docs ?? [];
                      // if (snapshot.connectionState == ConnectionState.waiting) {
                      //   return CircularProgressIndicator();
                      // }
                      if (notes.isEmpty &&
                          (snapshot.connectionState == ConnectionState.done)) {
                        return Text('No notes available.');
                      }
                      // Create a list of widgets for each note
                      List<Widget> noteWidgets = notes.map((note) {
                        return NotesCard(note.data());
                      }).toList();

                      // Create a list of rows with two notes in each row
                      List<Widget> rows = [];
                      for (int i = 0; i < noteWidgets.length; i += 2) {
                        if (i + 1 < noteWidgets.length) {
                          rows.add(Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              noteWidgets[i],
                              noteWidgets[i + 1],
                            ],
                          ));
                        } else {
                          // If there's an odd number of notes, add a single note in the last row
                          rows.add(Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [noteWidgets[i]],
                          ));
                        }
                      }
                      // Return a column with all the rows
                      return Column(children: rows);
                    }),
              if (_selectedIndex == 2)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NotesFolder(),
                    NotesFolder(),
                  ],
                )
            ],
          ),
        ));
  }
}
