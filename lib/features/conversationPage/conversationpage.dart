import 'package:flutter/material.dart';
import 'package:whatsapp_clone_flutter/core/models/conversations.dart';

import 'conversationpage_view.dart';

class ConversationPage extends StatefulWidget {
  const ConversationPage({
    Key? key,
    required this.conversation,
  }) : super(key: key);
  final Conversation conversation;

  ConversationPageView createState() => ConversationPageView();
}
