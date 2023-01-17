import 'package:flutter/material.dart';
import 'package:untitled/view/user_add.dart';
import '../constant/porject_text.dart';
import '../viewModel/user_view_model.dart';


class UserView extends StatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends UserViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(),
      floatingActionButton: AddFloatingActionButton(context),
      body: Column(
        children: [GetUserButton(), Expanded(child: buildListView())],
      ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
        itemCount: model.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(model[index].passwordName.toString()),
            subtitle: Text(model[index].password.toString()),
            trailing: ElevatedButton(
                onPressed: (() async {
                  await deleteUser(model[index].id ?? 0);
                }),
                child: Text(ProjectText.remove)),
          );
        });
  }

  FloatingActionButton AddFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => UserAdd()));
        },
        child: Text(ProjectText.add));
  }

  ElevatedButton GetUserButton() {
    return ElevatedButton(
        onPressed: () {
         getUser();
        },
        child: Text(ProjectText.get));
  }
}
