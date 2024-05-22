import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notecraft/models/todo.dart';
import 'package:notecraft/services/todos_service.dart';

class TodosList extends StatefulWidget {
  const TodosList({Key? key});

  @override
  State<TodosList> createState() => _TodosListState();
}

class _TodosListState extends State<TodosList> {
  final _formKey = GlobalKey<FormState>();
  final taskController = TextEditingController();
  final TodosService todosService = TodosService();

  @override
  void dispose() {
    taskController.dispose();
    super.dispose();
  }

  Future _displayNewTaskSheet(context) {
    return showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 243, 241, 241),
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black45.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          height: 190,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.check_box_outline_blank),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: taskController,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Enter your task details',
                            hintStyle: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w200,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(bottom: 5),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Builder(
                    builder: (context) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton.icon(
                            onPressed: null,
                            icon: const Icon(Icons.alarm_on),
                            label: const Text('Set Reminder'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (taskController.text.isNotEmpty) {
                                Todo task = Todo(
                                    task: taskController.text,
                                    completed: false);
                                TodosService().addTask(task);
                                taskController.clear();

                                //close the showModalBottomSheet
                                Navigator.pop(context);
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 241, 241),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton(
          elevation: 4.0,
          onPressed: () => _displayNewTaskSheet(context),
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            surfaceTintColor: Colors.transparent,
            expandedHeight: 65, // Adjust the height as needed 25
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(25, 5, 0, 15),
              title: const Text(
                "Todo's",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              background: Container(
                color: const Color.fromARGB(255, 243, 241, 241),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            StreamBuilder(
              stream: todosService.getTodosStream(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List todos = snapshot.data?.docs ?? [];
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      Todo todo = todos[index].data();

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(25, 5, 0, 15),
                        child: Row(
                          children: [
                            Theme(
                              data: Theme.of(context).copyWith(
                                unselectedWidgetColor: Colors.white,
                              ),
                              child: Transform.scale(
                                scale: 1.4,
                                child: Checkbox(
                                  checkColor: Colors.white,
                                  activeColor:
                                      Theme.of(context).colorScheme.primary,
                                  value: todo.completed,
                                  onChanged: (value) {
                                    Todo updateTask =
                                        todo.copyWith(completedValue: value!);
                                    TodosService().updateTask(updateTask);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              todo.task,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            )
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  // Display a loading indicator while waiting for the stream
                  return Center(child: CircularProgressIndicator());
                }
              },
            )
          ]))
          // Add other slivers (e.g., SliverList, SliverGrid) as needed
        ],
      ),
    );
  }
}
