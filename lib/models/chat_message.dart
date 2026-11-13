class ChatMessage {
  final String sender;
  final String text;
  final DateTime createdAt;

  const ChatMessage({
    required this.sender,
    required this.text,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'sender': sender,
        'text': text,
        'createdAt': createdAt.toIso8601String(),
      };

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      sender: json['sender'] as String? ?? 'Sistema',
      text: json['text'] as String? ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
    );
  }
}
