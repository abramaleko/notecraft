import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notecraft/services/notes_service.dart';
import 'package:notecraft/widgets/notes_cards.dart';
import 'package:notecraft/widgets/notes_folder.dart';
import 'package:notecraft/models/note.dart';

class Notes extends StatefulWidget {
  Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  int _selectedIndex = 1;
  bool _showAppBarText = false;
  ScrollController _scrollController = ScrollController();

  final NotesService notesService = NotesService();
  List notes = [];

  @override
  void initState() {
    super.initState();
    // Add a listener to the ScrollController
    _scrollController.addListener(_handleScroll);
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
          child: const Icon(
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
              title: const Text(
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
              const Padding(
                padding: EdgeInsets.only(left: 13, right: 13, top: 55),
                child: Text(
                  'Notes',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w700),
                ),
              ),
            
          ])),
        ],
      ),
    );
  }
}
