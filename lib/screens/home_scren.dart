import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/models/todo.dart';
import 'package:to_do_list/screens/todo_screen.dart';
import '../controllers/TodoController.dart';

class HomeScren extends StatelessWidget {
  const HomeScren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("GetX Todo List"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.to(TodoScreen());
        },
      ),
      body: Container(
        child: Obx(
          () => ListView.separated(
            itemBuilder: (context, index) => Dismissible(
              key: UniqueKey(),
              onDismissed: (_) {
                Todo? removed = todoController.todos[index];
                todoController.todos.removeAt(index);
                Get.snackbar(
                  'Task removed',
                  'The task "${removed.text}" was successfully removed.',
                  mainButton: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: const Size(60, 30),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2.0)),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text("Undo"),
                    onPressed: () {
                      if (removed.isNull) {
                        return;
                      }
                      todoController.todos.insert(index, removed!);
                      removed = null;
                      if (Get.isSnackbarOpen) {
                        Get.back();
                      }
                    },
                  ),
                );
              },
              child: ListTile(
                title: Text(
                  todoController.todos[index].text.toString(),
                  style: (todoController.todos[index].done)
                      ? const TextStyle(
                          color: Colors.red,
                          decoration: TextDecoration.lineThrough,
                        )
                      : const TextStyle(
                          color: Colors
                              .green, //Theme.of(context).textTheme.bodyText1.color,
                          decoration: TextDecoration.none,
                        ),
                ),
                onTap: () {
                  Get.to(TodoScreen(index: index));
                },
                leading: Checkbox(
                  value: todoController.todos[index].done,
                  onChanged: (v) {
                    var changed = todoController.todos[index];
                    changed.done = v!;
                    todoController.todos[index] = changed;
                  },
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
            separatorBuilder: (_, __) => const Divider(
              color: Colors.yellow,
            ),
            itemCount: todoController.todos.length,
          ),
        ),
      ),
    );
  }
}
