class Message {
  late int id_message;
  late int from_num;
  late int to_num;
  late String content;
  late int id_rdv;

  Message({
    required this.id_message,
    required this.from_num,
    required this.to_num,
    required this.content,
    required this.id_rdv,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id_message: json['id_message'],
      from_num: json['from_num'],
      to_num: json['to_num'],
      id_rdv: json['id_rdv'],
      content: json['content'],
      // sentAt: DateTime.fromMillisecondsSinceEpoch(json['sentAt']),
    );
  }
}
