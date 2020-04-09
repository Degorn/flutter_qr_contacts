class ContactModel {
  String name;
  String phone;

  ContactModel();

  ContactModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phone = json['phone'];

  Map<String, dynamic> toJson() => {
        'name': name ?? "",
        'phone': phone ?? "",
      };
}
