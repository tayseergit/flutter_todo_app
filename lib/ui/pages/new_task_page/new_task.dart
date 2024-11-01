import 'dart:ffi';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:todo/data/local/sqflite.dart';
import 'package:todo/domain/controller.dart';
import 'package:todo/ui/pages/add_page/add_task.dart';
import 'package:todo/ui/style/appColor.dart';
import 'package:todo/ui/widget/Big_text.dart';
import 'package:todo/ui/widget/Small_text.dart';
import 'package:todo/ui/widget/defult_botton.dart';
import 'package:todo/ui/widget/snakbar.dart';
import 'package:todo/ui/widget/subTitle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTaskPage extends StatefulWidget {
  NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  DateTime date = DateTime.now();
  var selectDate = DateTime.now().obs;
  Key _listViewKey = UniqueKey();

  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10.0,
        left: 15,
        right: 15,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Smalltext(DateFormat.yMMMd().format(date)),

                  // Smalltext("$date"),
                  BigText("Today"),
                ],
              ),
              DefultBotton(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AddTaskPage();
                  }));
                },
                hight: 60,
                width: 120,
                child: Smalltext(
                  "+Add Task",
                  color: Colors.white,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          ),
          DatePicker(
            DateTime.now(),
            height: 110,
            width: 80,
            selectionColor: AppColor.primaryColor,
            onDateChange: (date) {
              setState(() {
                selectDate.value = date;
                _listViewKey = UniqueKey();
                print(selectDate);
              });
            },
            daysCount: 60,
            dateTextStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            dayTextStyle: TextStyle(
              fontSize: 16,
            ),
            monthTextStyle: TextStyle(
              fontSize: 18,
            ),
            selectedTextColor: Colors.white,
            initialSelectedDate: DateTime.now(),
          ),
          SizedBox(
            height: 10,
          ),
          Obx(
            () => Expanded(
              key: _listViewKey,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: controller.newTask.length,
                itemBuilder: (context, index) {
                  if (controller.newTask[index]['repeat'] == 'Daily' ||
                      controller.newTask[index]['date'] ==
                          DateFormat.yMd().format(selectDate.value) ||
                      (controller.newTask[index]['repeat'] == 'weekly' &&
                          selectDate.value
                                      .difference(DateFormat.yMd().parse(
                                          controller.newTask[index]['date']))
                                      .inDays %
                                  7 ==
                              0) ||
                      (controller.newTask[index]['repeat'] == 'monthly' &&
                          DateFormat.yMd()
                                  .parse(controller.newTask[index]['date'])
                                  .day ==
                              selectDate.value.day)) {
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: Duration(milliseconds: 1400),
                        child: SlideAnimation(
                            verticalOffset: 100,
                            child: FadeInAnimation(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.bottomSheet(Container(
                                        color: AppColor.secondcolor,
                                        height: Get.height * .33,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.all(30),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: Get.width * 0.2,
                                                color: Colors.black,
                                                height: Get.height * .01,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              DefultBotton(
                                                onTap: () {
                                                  SqfliteCall.deletData(
                                                          controller.newTask[
                                                              index]["id"])
                                                      .then((value) {
                                                    SqfliteCall.getData(
                                                        SqfliteCall.database!);
                                                  });
                                                  Get.back();
                                                  CustomSnackbar.showSnackbar(
                                                      "Task is deleted ",
                                                      "",
                                                      Colors.red);
                                                },
                                                child: BigText("delete"),
                                                color: const Color.fromARGB(
                                                    255, 228, 118, 110),
                                                width: double.infinity,
                                                hight: Get.height * .06,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              DefultBotton(
                                                onTap: () {
                                                  SqfliteCall.setDoneTask(
                                                          id: controller
                                                                  .newTask[
                                                              index]["id"],
                                                          newStatus: "Done")
                                                      .then((value) {
                                                    SqfliteCall.getData(
                                                        SqfliteCall.database!);
                                                  });
                                                  // SqfliteCall.deletData(
                                                  //     controller.newTask[index]["id"]);
                                                  Get.back();
                                                },
                                                child: BigText("Done"),
                                                color: AppColor.primaryColor,
                                                width: double.infinity,
                                                hight: Get.height * .06,
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.02,
                                              ),
                                              DefultBotton(
                                                onTap: () {
                                                  Get.back();
                                                },
                                                child: Smalltext("close"),
                                                color: const Color.fromARGB(
                                                    255, 146, 144, 158),
                                                hight: Get.height * .04,
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                                    },
                                    child: Container(
                                      height: Get.height * 0.2,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10,
                                            top: 8,
                                            bottom: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Wrap(children: <Widget>[
                                                  BigText(
                                                    controller.newTask[index]
                                                        ["title"],
                                                    color: Colors.white,
                                                  ),
                                                ]),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.access_time_filled,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Smalltext(
                                                      " ${controller.newTask[index]["start_time"]} - ${controller.newTask[index]["end_time"]}",
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  // height: 20,
                                                  width: Get.width / 1.5,
                                                  child: Smalltext(
                                                    " *   ${controller.newTask[index]["note"]}",
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.event_repeat,
                                                      color: Colors.white,
                                                    ),
                                                    Smalltext(
                                                      "  ${controller.newTask[index]["repeat"]}",
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 100,
                                                      width: 2,
                                                      color: Colors.white,
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    RotatedBox(
                                                      quarterTurns: 3,
                                                      child: Smalltext(
                                                        "${controller.newTask[index]["status"]}",
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          // color: AppColor.primaryColor,
                                          color: controller.newTask[index]
                                                      ["color"] ==
                                                  0
                                              ? AppColor.primaryColor
                                              : controller.newTask[index]
                                                          ["color"] ==
                                                      1
                                                  ? Colors.pink[500]!
                                                  : Colors.amber[800]!,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            )));
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
