class UserModel {
  String? name;
  String? email;
  String? password;
  String? phone;
  String? id;

  UserModel({this.name, this.email, this.password, this.phone, this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['id'] = id;
    return data;
  }
}
