import 'package:flutter/material.dart';


import '../model/user_model.dart';
import '../service/user_database_provider.dart';
import '../view/user_add.dart';

abstract class UserAddViewModel extends State<UserAdd>{
  UserModel model = UserModel();
  UserDatabaseProvider userDatabaseProvider = UserDatabaseProvider();

  Future<void> saveModel() async{
    final result =  await userDatabaseProvider.insert(model);

  }
  @override
  void initState() {
    super.initState();
  }
}