import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/data/local/sqflite.dart';

class HomeController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    SqfliteCall.createDataBase();
  }

  int selected = 0;
  void changePage(int numbr) {
    selected = numbr;
    update();
  }

  var newTask = [].obs;

  void newTaskval(List<Map<String, dynamic>> value) {
    newTask.value = value;
  }
}
