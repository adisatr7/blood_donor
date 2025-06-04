class AiChatMessage {
  final int? id;
  final ChatSender sender;
  final String message;
  final DateTime? createdAt;

  AiChatMessage({
    this.id,
    required this.sender,
    required this.message,
    this.createdAt,
  });

  factory AiChatMessage.fromMap(Map<String, dynamic> map) {
    return AiChatMessage(
      id: map['id'] as int,
      sender: _senderStringToEnum(map['sender']),
      message: map['message'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {'message': message};
  }

  static ChatSender _senderStringToEnum(String senderString) {
    if (senderString == 'USER') {
      return ChatSender.user;
    } else if (senderString == 'MODEL') {
      return ChatSender.model;
    } else {
      throw Exception('Unknown sender type: $senderString');
    }
  }
}

enum ChatSender {
  user,
  model, // AI
}
