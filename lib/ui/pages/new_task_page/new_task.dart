import 'dart:ffi';

import 'package:get/get.dart';
import 'package:todo/data/local/sqflite.dart';
import 'package:todo/domain/controller.dart';
import 'package:todo/ui/pages/add_page/add_task.dart';
import 'package:todo/ui/style/appColor.dart';
import 'package:todo/ui/widget/Big_text.dart';
import 'package:todo/ui/widget/Small_text.dart';
import 'package:todo/ui/widget/defult_botton.dart';
import 'package:todo/ui/widget/subTitle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTaskPage extends StatelessWidget {
  NewTaskPage({super.key});
  DateTime date = DateTime.now();
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
          SizedBox(
            height: 10,
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemCount: controller.newTask.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        // height: 140,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(children: <Widget>[
                                    BigText(
                                      controller.newTask[index]["title"],
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
                                  Expanded(
                                    child: Smalltext(
                                      " *   ${controller.newTask[index]["note"]}",
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                          "Todo",
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
                            color: controller.newTask[index]["color"] == 0
                                ? AppColor.primaryColor
                                : controller.newTask[index]["color"] == 1
                                    ? Colors.pink[500]!
                                    : Colors.amber[800]!,
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
