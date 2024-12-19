class CrudUserModel {
  String? name;
  String? email;
  String? phone;

  CrudUserModel({
    this.name,
    this.email,
    this.phone,
  });

  CrudUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['pone'];
  }
}
