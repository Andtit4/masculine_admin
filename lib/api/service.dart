class ServiceModel {
  late int? id_service;
  late String? title;
  late String? heure_debut;
  late String? heure_fin;
  late String? genre;
  late String? img_url;
  late String? description;

  ServiceModel(
      {required this.id_service,
      required this.title,
      required this.heure_debut,
      required this.heure_fin,
      required this.description,
      required this.img_url,
      required this.genre});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
        id_service: json['id_service'],
        title: json['title'],
        heure_debut: json['heure_debut'],
        heure_fin: json['heure_fin'],
        description: json['description'],
        img_url: json['img_url'],
        genre: json['genre']);
  }
}
