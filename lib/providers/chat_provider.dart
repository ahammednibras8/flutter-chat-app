import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/model/chat_model.dart';
import 'package:flutter_chat_app/services/chat_service.dart';

class ChatProvider with ChangeNotifier {
  final ChatService _chatService = ChatService();

  String? _error;

  String? get error => _error;

  Stream<List<ChatModel>> getChats() {
    return _chatService.getChats();
  }
}
