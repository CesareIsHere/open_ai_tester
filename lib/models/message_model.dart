class MessageModel {
  String text;
  String sender;

  MessageModel({required this.text, required this.sender});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json['text'],
      sender: json['sender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'sender': sender,
    };
  }

  @override
  String toString() {
    return 'MessageModel{text: $text, sender: $sender}';
  }
}
