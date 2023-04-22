// ignore_for_file: non_constant_identifier_names

class RdvModel {
  late int id_rdv;
  late String? titre;
  late String? montant;
  late String? date_debut;
  late String? date_fin;
  late String? date_create;
  late String? nomuser;
  late String? prenomuser;
  late String? telephoneuser;
  late String? status;
  late String? mode_payement;
  late String? day;

  RdvModel(
      {required this.id_rdv,
      required this.titre,
      required this.date_create,
      required this.telephoneuser,
      required this.date_debut,
      required this.date_fin,
      required this.nomuser,
      required this.prenomuser,
      required this.mode_payement,
      required this.status,
      required this.day,
      required this.montant});

  factory RdvModel.fromJson(Map<String, dynamic> json) {
    return RdvModel(
        date_create: json["date_create"],
        date_debut: json["date_debut"],
        date_fin: json["date_fin"],
        id_rdv: json["id_rdv"],
        montant: json["montant"],
        telephoneuser: json["telephoneuser"],
        titre: json["titre"],
        nomuser: json["nomuser"],
        prenomuser: json["prenomuser"],
        status: json["status"],
        day: json['day'],
        mode_payement: json["mode_payement"]);
  }
}
