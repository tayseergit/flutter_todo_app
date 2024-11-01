import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/data/local/sqflite.dart';

class HomeController extends GetxController {
  var newTask = [].obs;
  var doneTask = [].obs;
  int them = 0;
  @override
  void onReady() {
    super.onReady();
    getWeekDates();
    SqfliteCall.createDataBase();
    print("height :${Get.height}");
    print("widht :${Get.width}");
  }

  int selected = 0;
  void changePage(int numbr) {
    selected = numbr;
    update();
  }

  void Taskval(List<Map<String, dynamic>> value) {
    newTask.value = [];
    doneTask.value = [];
    value.forEach((elements) {
      elements["status"] == "new"
          ? newTask.add(elements)
          : doneTask.add(elements);
    });
  }

  deleteAllTasks() async {
    await SqfliteCall.deleteAllData().then((value) {
      newTask.clear();
      doneTask.clear();
      // snack bar
      Get.snackbar('Tasks is Deleted', 'No any task now ...',
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          margin: EdgeInsets.symmetric(vertical: 20),
          borderRadius: 15,
          icon: Icon(
            Icons.nearby_error_rounded,
            size: 30,
            color: Colors.white,
          ));
    });
  }

  var selectedDate = DateTime.now().obs;

  // Function to update the selected date
  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

/////////  week section
  var selectDateIcon = (0).obs;
  var todayDate = DateTime.now().obs;

  var weekDates = <Map<String, dynamic>>[].obs;

  void selectDateIconF(int i) {
    selectDateIcon.value = i;
    // update();
  }

  void getWeekDates() {
    weekDates.clear();
    DateTime startDate = todayDate.value;
    for (int i = 0; i < 7; i++) {
      DateTime currentDate = startDate.add(Duration(days: i));
      String month = DateFormat('MMM').format(currentDate);
      String day = DateFormat('dd').format(currentDate);
      String dayName = DateFormat('EEE').format(currentDate);
      Map<String, String> dateMap = {
        "day": day,
        "month": month,
        "year": dayName,
      };
      weekDates.add(dateMap);
    }
    // update();
  }
}
