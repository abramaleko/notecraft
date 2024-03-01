import 'package:flutter/material.dart';

class NewNote extends StatefulWidget {
  const NewNote({Key? key}) : super(key: key);

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  bool isKeyboardOpen = false;

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 32,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Builder(
              builder: (context) {
                if (isKeyboardOpen &&
                    (titleController.text.isNotEmpty ||
                        noteController.text.isNotEmpty)) {
                  return IconButton(
                    icon: Icon(
                      Icons.check,
                      size: 32,
                    ),
                    onPressed: () {
                      // Add your button functionality here
                    },
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
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
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w200,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 5),
                    ),
                    onChanged: (text) {
                      setState(() {
                        // Check if any of the TextFields have text
                        isKeyboardOpen = FocusScope.of(context).hasFocus &&
                            (titleController.text.isNotEmpty ||
                                noteController.text.isNotEmpty);
                      });
                    }),
                SizedBox(height: 20),
                Text(
                  'March 1 10:18AM',
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
                  onChanged: (text) {
                    setState(() {
                      // Check if any of the TextFields have text
                      isKeyboardOpen = FocusScope.of(context).hasFocus &&
                          (titleController.text.isNotEmpty ||
                              noteController.text.isNotEmpty);
                    });
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
