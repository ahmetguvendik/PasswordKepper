import 'package:flutter/material.dart';

import '../constant/porject_text.dart';
import '../model/user_model.dart';
import '../viewModel/user_add_view_model.dart';


class UserAdd extends StatefulWidget {
  const UserAdd({Key? key}) : super(key: key);

  @override
  State<UserAdd> createState() => _UserAddState();
}

class _UserAddState extends UserAddViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            UserNameTextFieldWidget(model: model),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: AgeTextFieldWidget(model: model),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SaveButton(),
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton SaveButton() =>
      ElevatedButton(onPressed: saveModel, child: Text(ProjectText.save));
}

class UserNameTextFieldWidget extends StatelessWidget {
  const UserNameTextFieldWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return  TextField(
      onChanged: (value){
        model.passwordName = value;
      },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueAccent,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: "Password Name",
        ));
  }
}

class AgeTextFieldWidget extends StatelessWidget {
  const AgeTextFieldWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final UserModel model;

  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: (value){
          model.password = value;
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueAccent,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: "Password",
        ));
  }
}

/*
enum modelName{
  age,username
}

extension modelNameExtension on modelName{
  String get ModelName{
    switch(this){
      case modelName.age:
        return "age";
      case modelName.username:
        return "username";
    }
  }
}*/
