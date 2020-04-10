import 'dart:convert';

class ContactModel {
  final String name;
  final String phone;

  ContactModel({this.name, this.phone});

  ContactModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phone = json['phone'];

  Map<String, dynamic> toJson() => {
        'name': name ?? "",
        'phone': phone ?? "",
      };

  String toStringJson() => jsonEncode(toJson());
}
