import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/chat_message.dart';

class ChatProvider extends ChangeNotifier {
  static const String _storageKey = 'chat_messages';

  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => List.unmodifiable(_messages);

  Future<void> loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final rawMessages = prefs.getStringList(_storageKey) ?? const [];

    _messages
      ..clear()
      ..addAll(rawMessages.map((entry) {
        final decoded = jsonDecode(entry);
        if (decoded is Map<String, dynamic>) {
          return ChatMessage.fromJson(decoded);
        }
        return ChatMessage(
          sender: 'Sistema',
          text: entry,
          createdAt: DateTime.now(),
        );
      }));

    notifyListeners();
  }

  Future<void> addMessage({required String sender, required String text}) async {
    final trimmedText = text.trim();
    if (trimmedText.isEmpty) {
      return;
    }

    final message = ChatMessage(
      sender: sender,
      text: trimmedText,
      createdAt: DateTime.now(),
    );

    _messages.add(message);
    await _saveMessages();
    notifyListeners();
  }

  Future<void> addIncomingSyncMessage() async {
    final message = ChatMessage(
      sender: 'Sistema',
      text: 'Mensagem sincronizada em background às ${DateTime.now().toLocal().toString()}',
      createdAt: DateTime.now(),
    );

    _messages.add(message);
    await _saveMessages();
    notifyListeners();
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final serialized = _messages.map((message) => jsonEncode(message.toJson())).toList();
    await prefs.setStringList(_storageKey, serialized);
  }
}
