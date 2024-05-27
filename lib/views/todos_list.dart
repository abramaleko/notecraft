import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notecraft/models/todo.dart';
import 'package:notecraft/services/todos_service.dart';
import 'package:notecraft/widgets/NewTaskSheet.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 241, 241),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton(
          elevation: 4.0,
          onPressed: () => NewTaskSheet(context: context).displayNewTaskSheet(),
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
