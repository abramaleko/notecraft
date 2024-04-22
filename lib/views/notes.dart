import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notecraft/provider/note_provider.dart';
import 'package:notecraft/services/notes_service.dart';
import 'package:notecraft/widgets/notes_cards.dart';
import 'package:notecraft/widgets/notes_folder.dart';
import 'package:notecraft/models/note.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';

class Notes extends StatefulWidget {
  Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  int _selectedIndex = 1;
  bool _showAppBarText = false;
  ScrollController _scrollController = ScrollController();

  late final NotesService notesService;
  List notes = [];

  @override
  void initState() {
    super.initState();

    // notesService = NotesService();
    // notesService.getNotesStream().then((querySnapshot) {
    //   for (var docSnapshot in querySnapshot.docs) {
    //     setState(() {
    //       notes.add(docSnapshot.data());
    //     });
    //   }
    // });
    // Add a listener to the ScrollController
    _scrollController.addListener(_handleScroll);

    // NoteProvider noteProvider =
    Provider.of<NoteProvider>(context, listen: false).fetchNotesData();
  }

  void _handleScroll() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == 0) {
        // User has scrolled to the top
        if (_showAppBarText) {
          setState(() {
            _showAppBarText = false;
          });
        }
      } else {
        // User has scrolled to the bottom
        // print('Scrolled to the bottom');
        if (!_showAppBarText) {
          setState(() {
            _showAppBarText = true;
          });
        }
      }
    }
  }

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
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController, // Assign the controller
        slivers: [
          if (_showAppBarText)
            SliverAppBar(
              title: Text(
                'Notes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              floating: true,
              snap: true,
              pinned: true,
              centerTitle: true,
              expandedHeight: 45,
              backgroundColor: Colors.grey.shade100,
              scrolledUnderElevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(), // You can add background widget here
              ),
            ),
          SliverList(
              delegate: SliverChildListDelegate([
            if (!_showAppBarText) // Show the text in SliverList only when app bar text is hidden
              Padding(
                padding: const EdgeInsets.only(left: 13, right: 13, top: 55),
                child: Text(
                  'Notes',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
                ),
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
              Consumer<NoteProvider>(
                builder: (context, noteProvider, child) {
                  List<Widget> noteWidgets = noteProvider.notes.map((note) {
                    return GestureDetector(
                      onTap: () => context.goNamed('view-note', extra: note),
                      child: NotesCard(note),
                    );
                  }).toList();

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

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 13, right: 13, top: 10, bottom: 20),
                      child: SwipeTo(
                        onLeftSwipe: (details) {
                          setState(() {
                            _selectedIndex = 2;
                          });
                        },
                        child: Column(
                          children: rows,
                        ),
                      ),
                    ),
                  );
                },
              ),
            if (_selectedIndex == 2)
              Padding(
                padding: const EdgeInsets.only(left: 13, right: 13, top: 15),
                child: SwipeTo(
                  onRightSwipe: (details) {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NotesFolder(),
                      NotesFolder(),
                    ],
                  ),
                ),
              )
          ])),
        ],
      ),
    );
  }
}
