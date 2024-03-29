

import 'dart:convert';

import 'package:untitled1/src/models/Rol.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {



  String? id;
  String? email;
  String? name;
  String? lastname;
  String? phone;
  String? image;
  String?  password;
  String? sessionToken;
  List<Rol>? roles  = [];

  User({
    this.id,
    this.email,
    this.name,
    this.lastname,
    this.phone,
    this.image,
    this.password,
    this.sessionToken,
    this.roles,
  });


//metodo from json que recibe un mapa de valores y retorna un objeto de tipo User
  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    lastname: json["lastname"],
    phone: json["phone"],
    image: json["image"],
    password: json["password"],
    sessionToken: json["session_token"],
    roles: json["roles"] == null ? [] : List<Rol>.from(json["roles"].map((model) => Rol.fromJson(model))),
  );

  static List<User> fromJsonList(List<dynamic> jsonList) {
    List<User> toList = [];

    jsonList.forEach((item) {
      User users = User.fromJson(item);
      toList.add(users);
    });

    return toList;
  }

  //transforma un objeto de tipo map como si fuera de tipo json los transforma para enviarlos
  //transforma el modelo User a una objeto de tipo Map como si fuera un objeto json
  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "lastname": lastname,
    "phone": phone,
    "image": image,
    "password": password,
    "session_token": sessionToken,
    "roles" : roles
  };
}