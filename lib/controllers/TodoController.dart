import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/todo.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;

  @override
  void onInits() {
    List? storedTodos = GetStorage().read<List>("todos");
    if (!storedTodos.isNull) {
      todos = storedTodos!.map((e) => Todo.fromJson(e)).toList().obs;
    }
    ever(todos, (_) {
      GetStorage().write("todos", todos.toList());
    });
    super.onInit();
  }
}
