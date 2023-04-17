class NotificationModel {
  late int id_notification;
  late String content;
  late int telephoneuser;
  late String date_add;

  NotificationModel({
    required this.id_notification,
    required this.content,
    required this.telephoneuser,
    required this.date_add
      });

      factory NotificationModel.fromJson(Map<String, dynamic>json) {
        return NotificationModel(
          id_notification : json["id_notification"],
          content : json["content"],
          telephoneuser : json["telephoneuser"],
          date_add : json["date_add"],
        );
      }
}