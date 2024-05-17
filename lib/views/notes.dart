import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notecraft/services/notes_service.dart';
import 'package:notecraft/widgets/notes_cards.dart';
import 'package:notecraft/widgets/notes_folder.dart';
import 'package:notecraft/models/note.dart';

class Notes extends StatelessWidget {
  Notes({super.key});

  final NotesService notesService = NotesService();

  List notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 241, 241),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton(
          elevation: 4.0,
          onPressed: () => context.goNamed('new-note'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            surfaceTintColor: Colors.transparent,
            expandedHeight: 65, // Adjust the height as needed 25
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.fromLTRB(25, 5, 0, 15),
              title: const Text(
                'Notes',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              background: Container(
                color: Color.fromARGB(255, 243, 241, 241),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            StreamBuilder(
                stream: notesService.getNotesStream(),
                builder: (context, snapshot) {
                  List notes = snapshot.data?.docs ?? [];
                  if (notes.isEmpty &&
                      (snapshot.connectionState == ConnectionState.done)) {
                    return Center(child: Text('No notes available.'));
                  }

                  // Create a list of widgets for each note
                  List<Widget> noteWidgets = notes.map((note) {
                    return GestureDetector(
                      onTap: () =>
                          context.goNamed('view-note', extra: note.data()),
                      child: NotesCard(note.data()),
                    );
                  }).toList();

                  // Create a list of rows with two notes in each row
                  List<Widget> rows = [];
                  for (int i = 0; i < noteWidgets.length; i += 2) {
                    if (i + 1 < noteWidgets.length) {
                      rows.add(Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: noteWidgets[i]),
                          Expanded(child: noteWidgets[i + 1]),
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
                  // Return a column with all the rows wrapped inside a SingleChildScrollView
                  return SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 13, right: 13, top: 15),
                      child: Column(
                        children: rows,
                      ),
                    ),
                  );
                })
          ])),
        ],
      ),
    );
  }
}
