import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/data/local/sqflite.dart';
import 'package:todo/domain/Them_controller.dart';
import 'package:todo/domain/controller.dart';
import 'package:todo/ui/pages/done_page/done_task.dart';
import 'package:todo/ui/pages/new_task_page/new_task.dart';
import 'package:todo/ui/style/appColor.dart';
import 'package:flutter/material.dart';

GetStorage box = GetStorage();

class HomePage extends StatelessWidget {
  HomePage({super.key});
  HomeController controller = Get.put(HomeController());
  ThemController themController = Get.put(ThemController());
  String them = "white";

  List<Widget> bodies = [
    NewTaskPage(),
    DoneTaskPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => Scaffold(
          appBar: AppBar(
            toolbarHeight: 40,
            leading: Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                IconButton(
                  onPressed: () {
                    print("islight value is ${box.read("islight")}");
                    themController.changeThem();
                  },
                  icon: Icon(
                    themController.isLight ? Icons.dark_mode : Icons.light_mode,
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  controller.deleteAllTasks();
                  SqfliteCall.getData(SqfliteCall.database!);
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 30,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.circle_outlined,
                  size: 30,
                ),
              ),
              SizedBox(
                width: 20,
              )
            ],
          ),
          body: bodies[c.selected],
          bottomNavigationBar: BottomNavigationBar(
            // backgroundColor: Colors.grey[300],
            currentIndex: c.selected,
            onTap: (index) {
              c.changePage(index);
              print(c.selected);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.download), label: "Done"),
            ],
          )),
    );
  }
}
