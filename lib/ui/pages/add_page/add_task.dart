import 'dart:ffi';

import 'package:get/get.dart';
import 'package:todo/data/local/sqflite.dart';
import 'package:todo/data/model/task_model.dart';
import 'package:todo/domain/controller.dart';
import 'package:todo/ui/layout/home_page.dart';
import 'package:todo/ui/style/appColor.dart';
import 'package:todo/ui/widget/Big_text.dart';
import 'package:todo/ui/widget/Small_text.dart';
import 'package:todo/ui/widget/defult_botton.dart';
import 'package:todo/ui/widget/defult_field_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/ui/widget/snakbar.dart';

class AddTaskPage extends StatefulWidget {
  AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  int selectcol = 0;
  HomeController controller = Get.put(HomeController());

  List<String> remindList = ['5', '10', '15', "20", '25', "30"];
  List<String> repeatList = ["None", 'Daily', "weekly", 'monthly'];

  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(text: DateFormat.yMd().format(DateTime.now())),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(text: '5'),
    TextEditingController(text: 'None'),
  ];
  @override
  Widget build(BuildContext context) {
    var now = TimeOfDay.now();
    var hourLater = TimeOfDay(hour: now.hour + 1, minute: now.minute);

    String hourLaterTime = DateFormat.jm()
        .format(DateTime(2022, 1, 1, hourLater.hour, hourLater.minute));

    return Scaffold(
      // backgroundColor: Color,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.circle_outlined,
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 5,
                width: double.infinity,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Smalltext(
                      "color : ",
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Wrap(
                      spacing: 10,
                      children: List.generate(
                        3,
                        (index) => InkWell(
                          onTap: () {
                            setState(
                              () {
                                selectcol = index;
                              },
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index == 0
                                    ? AppColor.primaryColor
                                    : index == 1
                                        ? Colors.pink[500]
                                        : Colors.amber[800]),
                            child: selectcol == index
                                ? Icon(
                                    Icons.done,
                                    color: Colors.white,
                                  )
                                : Container(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              //////////////////////////  for background
              Container(
                decoration: BoxDecoration(
                    // color: Color.fromARGB(144, 171, 243, 153),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      BigText(
                        "Add Task",
                        size: 25,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                        children: [
                          DefultFormText(
                            controller: controllers[0],
                            text: "Title",
                            hinttext: "Add a Title",
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          DefultFormText(
                            controller: controllers[1],
                            text: "Note",
                            hinttext: "Add a Note",
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          DefultFormText(
                            controller: controllers[2],
                            text: "Date",
                            hinttext:
                                "${DateFormat.yMd().format(DateTime.now())}",
                            readonly: true,
                            keyboard: TextInputType.none,
                            suffix: IconButton(
                                onPressed: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime(2030))
                                      .then((value) {
                                    controllers[2].text =
                                        DateFormat.yMd().format(value!);
                                  }).catchError((e) {
                                    print(e.toString());
                                  });
                                },
                                icon: Icon(
                                  Icons.calendar_month,
                                  color: Colors.redAccent,
                                )),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DefultFormText(
                                  controller: controllers[3],
                                  text: "Start Time",
                                  readonly: true,
                                  hinttext: TimeOfDay.now().format(context),
                                  keyboard: TextInputType.none,
                                  suffix: IconButton(
                                      onPressed: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          controllers[3].text =
                                              value!.format(context);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.timelapse,
                                        color: Colors.redAccent,
                                      )),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: DefultFormText(
                                  controller: controllers[4],
                                  text: "End Time",
                                  readonly: true,
                                  
                                  hinttext: hourLaterTime,
                                  keyboard: TextInputType.none,
                                  suffix: IconButton(
                                      onPressed: () {
                                        showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) {
                                          controllers[4].text =
                                              value!.format(context);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.timelapse,
                                        color: Colors.redAccent,
                                      )),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          DefultFormText(
                            controller: controllers[5],
                            text: "Remind",
                            readonly: true,
                            keyboard: TextInputType.none,
                            suffix: DropdownButton(
                              dropdownColor: Colors.grey[300],
                              borderRadius: BorderRadius.circular(15),
                              padding: EdgeInsets.only(right: 10),
                              items: remindList.map((e) {
                                return DropdownMenuItem(
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.red,
                                    ),
                                  ),
                                  value: e,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  controllers[5].text = value!;
                                });
                              },
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.redAccent,
                                size: 40,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          DefultFormText(
                            controller: controllers[6],
                            text: "Repeat",
                            readonly: true,
                            suffix: DropdownButton(
                              dropdownColor: Colors.grey[300],
                              borderRadius: BorderRadius.circular(15),
                              padding: EdgeInsets.only(right: 10),
                              items: repeatList.map((e) {
                                return DropdownMenuItem(
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.red),
                                  ),
                                  value: e,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  controllers[6].text = value!;
                                });
                              },
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.redAccent,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: DefultBotton(
                    width: double.infinity,
                    color: selectcol == 0
                        ? AppColor.primaryColor
                        : selectcol == 1
                            ? Colors.pink[500]!
                            : Colors.amber[800]!,
                    onTap: () {
                      if (controllers[0].text.isEmpty ||
                          controllers[1].text.isEmpty ||
                          controllers[2].text.isEmpty ||
                          controllers[3].text.isEmpty ||
                          controllers[4].text.isEmpty) {
                        CustomSnackbar.showSnackbar(
                            "there is empty field", ".......", Colors.red);
                      } else {
                        SqfliteCall.insertData(
                          TaskModel(
                            title: controllers[0].text,
                            note: controllers[1].text,
                            date: controllers[2].text,
                            startTime: controllers[3].text,
                            endTime: controllers[4].text,
                            repeat: controllers[5].text,
                            remind: controllers[6].text,
                            color: selectcol,
                          ),
                        ).then((value) {
                          SqfliteCall.getData(SqfliteCall.database!);
                          Get.off(HomePage());
                        }).catchError((e) {
                          print(e.toString());
                        });
                        // SqfliteCall.getData(SqfliteCall.database!);
                      }
                    },
                    child: BigText(
                      "Creat",
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
