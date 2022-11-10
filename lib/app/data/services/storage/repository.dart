import 'package:getx_notes_app/app/data/modules/task.dart';
import 'package:getx_notes_app/app/data/providers/task/provider.dart';

class TaskRepository {
  //TODO: Clase encargada de solicitarle la informacion de escritura y lectura al provider
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});
  List<Task> readTasks() {
    return taskProvider.readTasks();
  }

  void writeTasks(List<Task> tasks) {
    taskProvider.writeTask(tasks);
  }
}
