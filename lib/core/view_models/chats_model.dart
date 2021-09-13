import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone_flutter/core/models/conversations.dart';
import 'package:whatsapp_clone_flutter/core/services/firestore_db.dart';

class ChatsModel with ChangeNotifier {
  final FirestoreDB _db = GetIt.instance<FirestoreDB>();
  Stream<List<Conversation>> conversations(String userId) {
    return _db.getConversations(userId);
  }
}
