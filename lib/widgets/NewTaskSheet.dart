 import 'package:flutter/material.dart';
import 'package:notecraft/models/todo.dart';
import 'package:notecraft/services/todos_service.dart';

class NewTaskSheet{

BuildContext context;

NewTaskSheet({required this.context});

Future displayNewTaskSheet() {
  
  final _formKey = GlobalKey<FormState>();
  final taskController = TextEditingController();
  final TodosService todosService = TodosService();

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

}