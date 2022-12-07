import 'package:flutter/material.dart';
import 'package:getx_notes_app/app/core/utils/extensions.dart';
import 'package:getx_notes_app/app/core/values/colors.dart';
import 'package:getx_notes_app/app/data/modules/task.dart';
import 'package:getx_notes_app/app/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:getx_notes_app/app/widgets/icons.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.sp;
    final editController = TextEditingController();

    //TODO:Widget que vampos a msotrar para a;adir una task
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
              radius: 5,
              title: 'Task Type',
              content: Form(
                  key: homeController.formKeys,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                        child: TextFormField(
                          controller: editController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Title',
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter your task title';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            homeController.editCttrl.text = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0.wp),
                        child: Wrap(
                          spacing: 3.0.wp,
                          children: icons
                              .map((e) => Obx(() {
                                    final index = icons.indexOf(e);
                                    return ChoiceChip(
                                      selectedColor: Colors.grey[400],
                                      pressElevation: 0,
                                      backgroundColor: Colors.white,
                                      label: e,
                                      selected:
                                          homeController.chipIndex.value ==
                                              index,
                                      onSelected: (bool selected) {
                                        homeController.changeChipIndex(
                                            selected ? index : 0);
                                      },
                                    );
                                  }))
                              .toList(),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (homeController.formKeys.currentState!
                                .validate()) {
                              int icon = icons[homeController.chipIndex.value]
                                  .icon!
                                  .codePoint;
                              String color =
                                  icons[homeController.chipIndex.value]
                                      .color!
                                      .toHex();

                              var task = Task(
                                  title: homeController.editCttrl.text,
                                  color: color,
                                  icon: icon);

                              homeController.addTask(task)
                                  ? EasyLoading.showSuccess(
                                      'Create successfully')
                                  : EasyLoading.showError('Duplicated Task');
                              Get.back();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              minimumSize: const Size(120, 40)),
                          child: const Text("Confirm")),
                    ],
                  )));
          homeController.editCttrl.clear();
          homeController.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
              child: Icon(
            Icons.add,
            size: 10.0.wp,
            color: Colors.grey,
          )),
        ),
      ),
    );
  }
}
