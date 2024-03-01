import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notecraft/widgets/notes_cards.dart';
import 'package:notecraft/widgets/notes_folder.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: FloatingActionButton(
            elevation: 4.0,
            onPressed:() => context.goNamed('new-note'),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NotesCard(),
                    NotesCard(),
                  ],
                ),
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
