import 'package:get/get.dart';
import 'package:todo/data/model/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/domain/controller.dart';
// create database
// create table
// insert to table
// select data from table
// delete
// update

class SqfliteCall {
  static HomeController controller = Get.put(HomeController());
  static String dbName = "todo.db";
  static String tableName = "taskes";
  static Database? database;
  static void createDataBase() async {
    // open the database
    database = await openDatabase(
      dbName,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        print("database created");
        await db
            .execute(
          'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, title TEXT, note TEXT, date TEXT ,start_time TEXT ,end_time TEXT ,remind TEXT ,repeat TEXT , color INTEGER, status TEXT)',
        )
            .then(
          (value) {
            print("table created");
          },
        ).catchError(
          (e) {
            print(e.toString());
          },
        );
      },
      onOpen: (database) {
        print("database opened");
        getData(database);
      },
    );
  }

  static Future insertData(TaskModel model) async {
    await database!.transaction((txn) async {
      return await txn
          .rawInsert(
              'INSERT INTO $tableName(title, note, date , start_time ,end_time ,remind ,repeat ,color ,status) VALUES("${model.title}", "${model.note}" , "${model.date}" ,"${model.startTime}" ,"${model.endTime}" ,"${model.repeat}" ,"${model.remind}",${model.color} , "new")')
          .then((value) {
        print("$value  row inserted");
      });
    });
  }

// List<Map<String, dynamic>> newTask = [];
  static getData(Database database) async {
    return await database.rawQuery('SELECT * FROM $tableName').then(
      (value) {
        controller.Taskval(value);
        print("task : ${controller.newTask}");
      },
    ).catchError((e) {
      print(e.toString());
    });
  }

  static Future deletData(int id) async {
    return await database!
        .rawDelete('DELETE FROM $tableName WHERE id = ?', [id]).then((value) {
      print("$value raw deleted");
    }).catchError((e) {
      print("$id cant deleted");
    });
  }

  static Future setDoneTask({
    required int id,
    required String newStatus,
  }) async {
    return await database!.rawUpdate(
        'UPDATE $tableName SET status = ? WHERE id = ?',
        [newStatus, id]).then((v) {
      print("$v updated");
    }).catchError((e) {
      print(e.toString());
    });
  }

  static Future<int> deleteAllData() async {
    return await database!.delete(tableName);
  }
}
