import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:getx_notes_app/app/data/modules/task.dart';
import 'package:getx_notes_app/app/data/services/storage/repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO:Controllador de la vista home
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  //Variables
  final tasks = <Task>[].obs;
  final formKeys = GlobalKey<FormState>();
  final chipIndex = 0.obs;
  final editCttrl = TextEditingController();
  final deleting = false.obs;
  final task = Rx<Task?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

  //Metodos
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    //Aqui cargamos las variables del repostitoryio que le pide al local storage
    tasks.assignAll(taskRepository.readTasks());

    //Aqui cada vez que cambie la lista de task se va a encargar de solicitar al repositorio que actulize ese lsitado con la nuevas task en el local
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    // TODO: implement onClose
    editCttrl.dispose();
    super.onClose();
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (int i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo['done'];
      if (status) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  //esto es para seleccionar la task con la que se va a trabajar
  void changeTask(Task? select) {
    task.value = select;
  }

//metodo para añadir una todo a un listado de todos de una task
  updateTask(Task task, String text) {
    //obtenemos los todos de la tarea seleccionado de no existir creamos un listado vacio
    var todos = task.todos ?? [];
    //validamos que no exista ya ese todo
    if (containeTodo(todos, text)) {
      return false;
    }
    //creo el todo
    var todo = {'title': text, 'done': false};
    //se lo addiciono al listado de todos de la tarea seleccionada
    todos.add(todo);
    //actualizo la tarea selcecionada con un nuevo listado de todos
    var newTask = task.copyWith(todos: todos);
    //pregunto el indice de la tarea seleccionada
    int oldIndex = tasks.indexOf(task);
    //reemplazo la tarea actualizada del listado de tareas
    tasks[oldIndex] = newTask;

    tasks.refresh();
    return true;
  }

  bool containeTodo(List todos, String task) {
    return todos.any((element) => element['title'] == task);
  }

  bool addTodo(String text) {
    var todo = {'title': text, 'done': false};

    //revisamos si el todo que vamos a a;adir esta en el listado de los doing si es asi no hacemo0s nada solo devoilvemos false
    if (doingTodos
        .any((element) => mapEquals<String, dynamic>(todo, element))) {
      return false;
    }
    //revisamos si el doneTodo que vamos a a;adir esta en el listado de los donetodos si es asi no hacemo0s nada solo devoilvemos false
    var doneTodo = {'title': text, 'done': true};
    if (doneTodos
        .any((element) => mapEquals<String, dynamic>(doneTodo, element))) {
      return false;
    } else {
      doingTodos.add(todo);
      return true;
    }
  }

  void updateTodos() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([
      ...doingTodos,
      ...doneTodos,
    ]);

    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIndx = tasks.indexOf(task.value);
    tasks[oldIndx] = newTask;
    tasks.refresh();
  }

  void doneTodo(String title) {
    var doingTodo = {'title': title, 'done': false};
    int index = doingTodos.indexWhere(
        (element) => mapEquals<String, dynamic>(doingTodo, element));

    doingTodos.removeAt(index);

    var doneTodo = {'title': title, 'done': true};
    doneTodos.add(doneTodo);

    doneTodos.refresh();
    doingTodos.refresh();
  }
}
