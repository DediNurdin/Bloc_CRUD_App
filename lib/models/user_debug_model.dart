import 'dart:convert';

List<UserDebugModel> userDebugFromJson(String str) => List<UserDebugModel>.from(
    json.decode(str).map((x) => UserDebugModel.fromJson(x)));

String userDebugToJson(List<UserDebugModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserDebugModel {
  UserDebugModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  final String id;
  final String name;
  final String email;
  final String phone;

  factory UserDebugModel.fromJson(Map<String, dynamic> json) => UserDebugModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
      };
}
