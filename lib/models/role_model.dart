// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

RoleModel roleModelFromJson(String str) => RoleModel.fromJson(json.decode(str));

class RoleModel {
  RoleModel({
    required this.role,
  });

  List<Role> role;

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        role: List<Role>.from(json["role"].map((x) => Role.fromJson(x))),
      );
}

class Role {
  Role({
    required this.name,
  });

  String name;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        name: json["name"],
      );
}