import 'package:flutter/cupertino.dart';
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

  void ChangeChipIndex(int value) {
    chipIndex.value = value;
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }
}
