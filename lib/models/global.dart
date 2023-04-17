class GlobalNotifModel {
  late int id_global_notif;
  late String content;
  // late int telephoneuser;
  late String date_create;

  GlobalNotifModel(
      {required this.id_global_notif,
      required this.content,
      // required this.telephoneuser,
      required this.date_create});

  factory GlobalNotifModel.fromJson(Map<String, dynamic> json) {
    return GlobalNotifModel(
      id_global_notif: json["id_global_notif"],
      content: json["content"],
      // telephoneuser : json["telephoneuser"],
      date_create: json["date_create"],
    );
  }
}
