import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String id;
  final List<String> participants;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String lastMessageSenderId;
  final int unreadCount;
  final bool isGroup;
  final String? groupName;
  final String? groupImage;

  ChatModel(
      {required this.id,
      required this.participants,
      required this.lastMessage,
      required this.lastMessageTime,
      required this.lastMessageSenderId,
      this.unreadCount = 0,
      this.isGroup = false,
      this.groupName,
      this.groupImage});

  factory ChatModel.fromMap(Map<String, dynamic> map, String docId) {
    return ChatModel(
      id: docId,
      participants: List<String>.from(map['participants'] ?? []),
      lastMessage: map['lastMessage'] ?? '',
      lastMessageTime:
          (map['lastMessageTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastMessageSenderId: map['lastMessageSenderId'] ?? '',
      unreadCount: map['unreadCount'] ?? 0,
      isGroup: map['isGroup'] ?? false,
      groupName: map['groupName'],
      groupImage: map['groupImage'],
    );
  }
}
