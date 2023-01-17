class UserModel {
  int? id;
  String? passwordName;
  String? password;

  UserModel({this.id, this.passwordName, this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    passwordName = json['passwordName'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['passwordName'] = this.passwordName;
    data['password'] = this.password;
    return data;
  }
}