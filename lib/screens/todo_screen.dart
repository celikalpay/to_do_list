import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_list/controllers/TodoController.dart';
import 'package:to_do_list/models/todo.dart';

class TodoScreen extends StatelessWidget {
  // TodoScreen({Key? key}) : super(key: key);
  final TodoController todoController = Get.find();
  final int? index;
  TodoScreen({this.index});
  @override
  Widget build(BuildContext context) {
    String text = "";
    if (!this.index.isNull) {
      text = todoController.todos[index!].text!;
    }
    TextEditingController textEditingController =
        TextEditingController(text: text);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: textEditingController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "What do you to accopish?",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: const TextStyle(fontSize: 25.0),
                keyboardType: TextInputType.multiline,
                maxLines: 999,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  child: const Text("Cancel"),
                  color: Colors.red,
                  onPressed: () {
                    Get.back();
                  },
                ),
                RaisedButton(
                  child: Text((index.isNull) ? "Add" : "Edit"),
                  color: Colors.green,
                  onPressed: () {
                    if (index.isNull) {
                      todoController.todos
                          .add(Todo(text: textEditingController.text));
                    } else {
                      var editing = todoController.todos[index!];
                      editing.text = textEditingController.text;
                      todoController.todos[index!] = editing;
                    }

                    Get.back();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
