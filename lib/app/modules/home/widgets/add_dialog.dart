import 'package:flutter/material.dart';
import 'package:getx_notes_app/app/core/utils/extensions.dart';
import 'package:getx_notes_app/app/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddDialog extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: homeCtrl.formKeys,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                        homeCtrl.editCttrl.clear();
                        homeCtrl.changeTask(null);
                      },
                      icon: const Icon(Icons.close)),
                  TextButton(
                      //TODO:PARA QUE AL PRESIONAR NO MUESTRE ninguna sombra
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () {
                        //TODO AQUI DEBEMOS LLAMAR AUN METODO EN EL CONTROLLER QUE SE ENCARGUE DE GUARDAR LOS DATOS
                        //VALIDANDO UN FORMULARIO

                        if (homeCtrl.formKeys.currentState!.validate()) {
                          //aqui valido si esta selecionada alguna de las tareas
                          if (homeCtrl.task.value == null) {
                            EasyLoading.showError('Please select task type');
                          } else {
                            //aqui llamos a a;adir el nuevo todo en las tareas
                            var sucess = homeCtrl.updateTask(
                                homeCtrl.task.value!, homeCtrl.editCttrl.text);
                            if (sucess) {
                              //limpiamos el text controller y limpiamos el tipo de tarea seleccionado
                              EasyLoading.showSuccess('Todo item add success');
                              Get.back();
                              homeCtrl.editCttrl.clear();
                              homeCtrl.changeTask(null);
                            } else {
                              EasyLoading.showError('Todo item already exist');
                            }

                            homeCtrl.editCttrl.clear();
                          }
                        }
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(
                            fontSize: 16.0.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue),
                      ))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: Text(
                "New Task",
                style:
                    TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: TextFormField(
                controller: homeCtrl.editCttrl,
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!))),
                autofocus: true,
                //TODO:VALIDATOR PARA VER SI SE LLENAN LOS DATOS
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a todo item';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 5.0.wp, left: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
              child: Text('Add to',
                  style: TextStyle(fontSize: 14.0.sp, color: Colors.grey)),
            ),
            ...homeCtrl.tasks
                .map((element) => Obx(
                      () => InkWell(
                        onTap: () => homeCtrl.changeTask(element),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0.wp, horizontal: 5.0.wp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    IconData(element.icon,
                                        fontFamily: 'MaterialIcons'),
                                    color: HexColor.fromHex(element.color),
                                  ),
                                  SizedBox(
                                    width: 3.0.wp,
                                  ),
                                  Text(
                                    element.title,
                                    style: TextStyle(
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              if (homeCtrl.task.value == element)
                                const Icon(
                                  Icons.check,
                                  color: Colors.blue,
                                )
                            ],
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ],
        ),
      ),
    );
  }
}
