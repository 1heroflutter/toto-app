import '../../../domain/assistant/entities/message.dart';

class MessageModel extends Message {
  const MessageModel({
    required super.text,
    required super.isUser,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      text: json['text'],
      isUser: json['is_user'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'text': text,
    'is_user': isUser,
  };
}
