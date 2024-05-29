import 'package:flutter/material.dart';
import 'package:notecraft/models/todo.dart';
import 'package:notecraft/services/todos_service.dart';

class ViewTaskDetails {
  BuildContext context;

  Todo todo;

  ViewTaskDetails({required this.context, required this.todo});

  Future showTaskModal() {
    final _formKey = GlobalKey<FormState>();
    final taskController = TextEditingController();
    final TodosService todosService = TodosService();

    taskController.text = todo.task;

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
                            onPressed: () {
                              todosService.deleteNote(todo.id);
                              // //close the showModalBottomSheet
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            label: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.red),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (taskController.text.isNotEmpty) {
                                todo = todo.copyWith(
                                    completedValue: false,
                                    task: taskController.text);

                                TodosService().updateTask(todo);
                                taskController.clear();

                                // //close the showModalBottomSheet
                                Navigator.pop(context);
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'Update',
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
}
