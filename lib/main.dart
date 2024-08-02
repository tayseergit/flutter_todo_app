import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:todo/ui/layout/home_page.dart';
import 'package:todo/ui/pages/add_page/add_task.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
