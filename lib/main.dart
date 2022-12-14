import 'package:flutter/material.dart';
import 'package:getx_notes_app/app/modules/home/home_view.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Todo List using Getx',
      home: HomePage(),
    );
  }
}
