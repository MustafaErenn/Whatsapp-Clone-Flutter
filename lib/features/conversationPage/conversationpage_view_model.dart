import 'package:flutter/widgets.dart';
import 'package:whatsapp_clone_flutter/features/conversationPage/conversationpage.dart';

abstract class ConversationPageViewModel extends State<ConversationPage> {
  final TextEditingController editingController = TextEditingController();

  late FocusNode focusNode;
  late ScrollController scrollController;
  bool keyboardVisible = false;
  @override
  void initState() {
    focusNode = FocusNode();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
