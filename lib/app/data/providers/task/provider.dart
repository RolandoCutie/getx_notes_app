import 'dart:convert';

import 'package:getx_notes_app/app/core/utils/keys.dart';
import 'package:getx_notes_app/app/data/modules/task.dart';
import 'package:getx_notes_app/app/data/services/storage/services.dart';
import 'package:get/get.dart';

class TaskProvider {


  //TODO:CLASE QUE SE VA AENCARGAR DE SER LA COMUNICACION con la data local
  StorageService _storage = Get.find<StorageService>();
  

  //TODO:Este metodo es para leer los datos de las tareas desde el alamacenamiento local
  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  //TODO:Este metodo es para escribir en el alamacenamiento local los datos de las tareas

  void writeTask(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
