class UserModel {
  late int? id;
  late String? nomuser;
  late String? prenomuser;
  late String? telephoneuser;
  late String? type_compte;

  UserModel(
      {required this.id,
      required this.nomuser,
      required this.prenomuser,
      required this.telephoneuser,
      required this.type_compte});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json["id"],
        nomuser: json["nomuser"],
        prenomuser: json["prenomuser"],
        telephoneuser: json["telephoneuser"],
        type_compte: json["type_compte"]);
  }
}
