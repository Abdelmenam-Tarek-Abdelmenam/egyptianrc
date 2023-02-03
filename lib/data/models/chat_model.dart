class MessageChat {
  String idFrom;
  String id;
  String timestamp;
  String content;

  MessageChat({
    required this.id,
    required this.idFrom,
    required this.timestamp,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      "sender": idFrom,
      "time": timestamp,
      "content": content,
    };
  }

  factory MessageChat.fromJson(json, String id) {
    return MessageChat(
      id: id,
      idFrom: json['sender'],
      timestamp: json['time'],
      content: json['content'],
    );
  }
}
