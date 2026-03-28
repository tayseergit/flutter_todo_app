import 'package:get/get.dart';
import 'package:todoo/data/model/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoo/domain/controller.dart';
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
        await db
            .execute(
              'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, title TEXT, note TEXT, date TEXT ,start_time TEXT ,end_time TEXT ,remind TEXT ,repeat TEXT , color INTEGER, status TEXT)',
            );
      },
      onOpen: (database) {
        getData(database);
      },
    );
  }

  static Future insertData(TaskModel model) async {
    await database!.transaction((txn) async {
      return await txn.rawInsert(
        'INSERT INTO $tableName(title, note, date , start_time ,end_time ,remind ,repeat ,color ,status) VALUES("${model.title}", "${model.note}" , "${model.date}" ,"${model.startTime}" ,"${model.endTime}" ,"${model.repeat}" ,"${model.remind}",${model.color} , "new")',
      );
    });
  }

  // List<Map<String, dynamic>> newTask = [];
  static getData(Database database) async {
    return await database.rawQuery('SELECT * FROM $tableName').then((value) {
      controller.Taskval(value);
    });
  }

  static Future deletData(int id) async {
    return await database!.rawDelete('DELETE FROM $tableName WHERE id = ?', [id]);
  }

  static Future setDoneTask({
    required int id,
    required String newStatus,
  }) async {
    return await database!.rawUpdate('UPDATE $tableName SET status = ? WHERE id = ?', [
      newStatus,
      id,
    ]);
  }

  static Future<int> deleteAllData() async {
    return await database!.delete(tableName);
  }
}
