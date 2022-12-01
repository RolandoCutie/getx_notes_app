import 'package:flutter/material.dart';
import 'package:getx_notes_app/app/data/services/storage/services.dart';
import 'package:getx_notes_app/app/modules/home/home_binding.dart';
import 'package:getx_notes_app/app/modules/home/home_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List using Getx',
      initialBinding: HomeBinding(),
      home: const HomePage(),
      builder: EasyLoading.init(),
    );
  }
}
