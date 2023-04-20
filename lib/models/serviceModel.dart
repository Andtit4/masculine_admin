// ignore: file_names
class ServiceModel {
  late int? id_service;
  late String? title;
  late String? heure_debut;
  late String? heure_fin;
  late String? genre;
  late String? description;
  late String? img_url;
  late String? titre_categorie;
  late int? montant;
  final String? day_begin;
  final String? day_end;

  ServiceModel(
      {required this.description,
      required this.genre,
      required this.heure_debut,
      required this.heure_fin,
      required this.id_service,
      required this.img_url,
      required this.montant,
      required this.title,
      required this.day_begin,
      required this.day_end,
    /*   required this.day_begin,
      required this.day_end, */
      required this.titre_categorie});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
        description: json['description'],
        genre: json['genre'],
        heure_debut: json['heure_debut'],
        heure_fin: json['heure_fin'],
        id_service: json['id_service'],
        img_url: json['img_url'],
        montant: json['montant'],
        title: json['title'],
        day_begin: json['day_begin'],
        day_end: json['day_end'],
        /* day_begin: json['day_begin'],
        day_end: json['day_end'], */
        titre_categorie: json['titre_categorie']);
  }
}
