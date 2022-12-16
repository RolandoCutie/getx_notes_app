import 'package:flutter/material.dart';
import 'package:getx_notes_app/app/core/utils/extensions.dart';
import 'package:getx_notes_app/app/data/modules/task.dart';
import 'package:getx_notes_app/app/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:getx_notes_app/app/modules/home/widgets/add_card.dart';
import 'package:getx_notes_app/app/modules/home/widgets/add_dialog.dart';
import 'package:getx_notes_app/app/modules/home/widgets/task_card.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../core/values/colors.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);
  //TODO:HOME PAGE
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(children: [
        Padding(
          padding: EdgeInsets.all(4.0.wp),
          child: Text(
            "My List",
            style: TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
          ),
        ),
        Obx(() => GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...controller.tasks
                    .map((element) => LongPressDraggable(
                        data: element,
                        onDragStarted: () => controller.changeDeleting(true),
                        onDraggableCanceled: (_, __) =>
                            controller.changeDeleting(false),
                        onDragEnd: (_) => controller.changeDeleting(false),
                        feedback: const Opacity(
                          opacity: 0.8,
                        ),
                        child: TaskCard(task: element)))
                    .toList(),
                AddCard()
              ],
            ))
      ])),
      floatingActionButton: DragTarget<Task>(
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Delete Succes');
        },
        builder: (_, __, ___) {
          return Obx(() => FloatingActionButton(
                backgroundColor: controller.deleting.value ? Colors.red : blue,
                onPressed: () {
                  //Here whe check if the are task
                  if (controller.tasks.isNotEmpty) {
                    //in case that whe have a task
                    Get.to(() => AddDialog(), transition: Transition.downToUp);
                  } else {
                    //wwe show a notifications to the user in casse that are not any task created
                    EasyLoading.showError(
                        'There are no task created. Please create your task');
                  }
                },
                child:
                    Icon(controller.deleting.value ? Icons.delete : Icons.add),
              ));
        },
      ),
    );
  }
}
