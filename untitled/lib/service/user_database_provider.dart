import 'package:sqflite/sqflite.dart';

import '../model/user_model.dart';

class UserDatabaseProvider {
  static Database? database;
  final String _databaseName = "PasswordDatabase";
  final String _tableName = "key";
  final String _columnId = "id";
  final String _columnUserName = "passwordName";
  final String _columnAge = "password";
  final int version = 1;

  Future<void> open() async {
    database = await openDatabase(_databaseName, version: version,
        onCreate: (db, version) async{
          await db.execute(
              "CREATE TABLE $_tableName($_columnId INTEGER PRIMARY KEY AUTOINCREMENT, $_columnUserName VARCHAR(30), $_columnAge VARCHAR(20))");
        });
  }

  /*Future<void> onCreateDb(Database db) async {
    await db.execute(
        "Create Table $_tableName($_columnId INTEGER PRIMARY KEY AUTOINCREMENT, $_columnUserName VARCHAR(20), $_columnAge INTEGER, $_columnIsMarried BOOLEAN)");
  }*/

  Future<List<UserModel>> getUser() async {
    if(database !=null) open();
    var userMaps = await database!.query(_tableName);
    return userMaps.map((e) => UserModel.fromJson(e)).toList();
  }

  Future<UserModel?> getUserWithId(int id) async {
    if(database !=null) open();
    var userMaps = await database!
        .query(_tableName, where: "$_columnId = ?", whereArgs: [id]);
    if (userMaps.isNotEmpty) {
      return UserModel.fromJson(userMaps.first);
    } else {
      return null;
    }
  }

  Future<bool> insert(UserModel model) async {
    var userMaps = await database?.insert(_tableName, model.toJson());
    print(model.toJson().toString() + "" + _tableName);
    return true;
  }

  Future<bool> delete(int id) async{
    var userMaps = await database!.delete(_tableName , where: "$_columnId = ?", whereArgs: [id]);
    return true;
  }

}
