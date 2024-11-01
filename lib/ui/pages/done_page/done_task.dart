import 'package:todo/ui/widget/Big_text.dart';
import 'package:flutter/material.dart';

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
import 'package:todo/ui/widget/subTitle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoneTaskPage extends StatelessWidget {
  DoneTaskPage({super.key});
  HomeController controller = Get.put(HomeController());
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return controller.doneTask.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BigText("No done task "),
              Row(),
            ],
          )
        : Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 15,
              right: 15,
            ),
            child: Column(
              children: [
                Obx(
                  () => Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: controller.doneTask.length,
                      itemBuilder: (context, index) {
                        return Column(
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
                                            SqfliteCall.deletData(controller
                                                    .doneTask[index]["id"])
                                                .then((value) {
                                              SqfliteCall.getData(
                                                  SqfliteCall.database!);
                                            });
                                            Get.back();
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
                                height: 140,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10, top: 8, bottom: 8),
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
                                              controller.doneTask[index]
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
                                                " ${controller.doneTask[index]["start_time"]} - ${controller.doneTask[index]["end_time"]}",
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Expanded(
                                            child: Smalltext(
                                              " *   ${controller.doneTask[index]["note"]}",
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          )
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
                                                  "${controller.doneTask[index]["status"]}",
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
                                    color:
                                        controller.doneTask[index]["color"] == 0
                                            ? AppColor.primaryColor
                                            : controller.doneTask[index]
                                                        ["color"] ==
                                                    1
                                                ? Colors.pink[500]!
                                                : Colors.amber[800]!,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
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
