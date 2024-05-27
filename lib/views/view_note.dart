import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:notecraft/models/note.dart';
import 'package:notecraft/services/notes_service.dart';

class ViewNote extends StatefulWidget {
  const ViewNote({super.key, required this.note});

  final Note note;

  @override
  State<ViewNote> createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  late Stream<DocumentSnapshot> _noteStream;
  NotesService notesService = NotesService();
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final noteService = NotesService();
  late String dateAdded;
  bool isKeyboardOpen = false;

  // @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController.text = widget.note.title;
    noteController.text = widget.note.content;
    dateAdded = DateFormat('MMMM d, y\'').format(widget.note.createdAt);
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  update({bool? pinned}) async {
    Note updateValues = widget.note.copyWith(
        titleController.text, noteController.text, DateTime.now(), pinned);
    noteService.updateNote(updateValues);
    context.pop();
  }

  deleteNote(noteId) async {
    notesService.deleteNote(noteId);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 32,
          ),
          onPressed: update,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Builder(
              builder: (context) {
                if (isKeyboardOpen) {
                  return IconButton(
                    icon: Icon(
                      Icons.check,
                      size: 32,
                    ),
                    onPressed: update,
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
          PopupMenuButton(
            padding: EdgeInsetsDirectional.all(10),
            position: PopupMenuPosition.under,
            elevation: 0,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(widget.note.pinned == false ? 'Pin' : 'Unpin'),
                onTap: () =>
                    update(pinned: widget.note.pinned == true ? false : true),
              ),
              PopupMenuItem(
                child: Text('Delete'),
                onTap: () => deleteNote(widget.note.id),
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: titleController,
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w200,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(bottom: 5),
                  ),
                  onChanged: (value) => {
                    setState(
                      () => isKeyboardOpen =
                          FocusScope.of(context).hasFocus ? true : false,
                    )
                  },
                ),
                SizedBox(height: 20),
                Text(
                  dateAdded,
                  style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),
                ),
                SizedBox(height: 25),
                TextField(
                  controller: noteController,
                  maxLines: null,
                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                  decoration: InputDecoration(
                    hintText: 'Start typing ...',
                    hintStyle: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w200,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(bottom: 5),
                  ),
                  onChanged: (value) => {
                    setState(
                      () => isKeyboardOpen =
                          FocusScope.of(context).hasFocus ? true : false,
                    )
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
