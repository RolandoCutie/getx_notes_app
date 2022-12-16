import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_notes_app/app/core/utils/extensions.dart';
import 'package:getx_notes_app/app/modules/details/widgets/doing_list.dart';
import 'package:getx_notes_app/app/modules/home/home_controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DetailPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value!;
    var color = HexColor.fromHex(task.color);
    var icon = task.icon;
    return Scaffold(
      body: Form(
        key: homeCtrl.formKeys,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                        homeCtrl.updateTodos();
                        homeCtrl.changeTask(null);
                        homeCtrl.editCttrl.clear();
                      },
                      icon: const Icon(Icons.arrow_back))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
              child: Row(
                children: [
                  Icon(
                    IconData(icon, fontFamily: 'MaterialIcons'),
                    color: color,
                  ),
                  SizedBox(
                    width: 3.0.wp,
                  ),
                  Text(
                    task.title,
                    style: TextStyle(
                        fontSize: 16.0.sp, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Obx(() {
              var totalTodos =
                  homeCtrl.doingTodos.length + homeCtrl.doneTodos.length;

              return Padding(
                padding:
                    EdgeInsets.only(left: 18.0.wp, top: 3.0.wp, right: 10.0.wp),
                child: Row(
                  children: [
                    //task todo icon and todo name
                    Text(
                      '$totalTodos Tasks',
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 3.0.wp,
                    ),

                    //Indicator
                    Expanded(
                        child: StepProgressIndicator(
                      totalSteps: totalTodos == 0 ? 1 : totalTodos,
                      currentStep: homeCtrl.doneTodos.length,
                      size: 5,
                      padding: 0,
                      selectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [color.withOpacity(0.5), color]),
                      unselectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey[300]!, Colors.grey[300]!]),
                    ))
                  ],
                ),
              );
            }),
            //text form field to add todo
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeCtrl.editCttrl,
                autofocus: true,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!)),
                    prefixIcon: Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey[400],
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          if (homeCtrl.formKeys.currentState!.validate()) {
                            var success =
                                homeCtrl.addTodo(homeCtrl.editCttrl.text);
                            if (success) {
                              EasyLoading.showSuccess(
                                  'Todo item added successfully');
                            } else {
                              EasyLoading.showError('Todo item already exist');
                            }
                            homeCtrl.editCttrl.clear();
                          }
                        },
                        icon: const Icon(Icons.done))),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a todo item';
                  }
                  return null;
                },
              ),
            ),
            DoingList(),
          ],
        ),
      ),
    );
  }
}
