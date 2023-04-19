class CategorieModel {
  late int? id_categorie;
  late String? titre_categorie;
  late String? description_categorie;
  late String? sexe;
  late String? img_categorie;

  CategorieModel(
      {required this.description_categorie,
      required this.id_categorie,
      required this.sexe,
      required this.img_categorie,
      required this.titre_categorie});

  factory CategorieModel.fromJson(Map<String, dynamic> json) {
    return CategorieModel(
        description_categorie: json['description_categorie'],
        id_categorie: json['id_categorie'],
        sexe: json['sexe'],
        img_categorie: json['img_categorie'],
        titre_categorie: json['titre_categorie']);
  }
}
