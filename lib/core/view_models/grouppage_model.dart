import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone_flutter/core/models/conversations.dart';
import 'package:whatsapp_clone_flutter/core/services/firestore_db.dart';
import 'package:whatsapp_clone_flutter/core/services/locator.dart';
import 'package:whatsapp_clone_flutter/core/services/storage_service.dart';

class GroupPageModel extends ChangeNotifier {
  final StorageService _storageService = getIt<StorageService>();
  String mediaUrl = '';
  final FirestoreDB _db = GetIt.instance<FirestoreDB>();
  Future<Conversation> startGroupConversation(
      List<String> members, String groupName, String ppUrl) async {
    var conversation =
        await _db.startGroupConversation(members, groupName, ppUrl);

    // burası direkt bizi grup mesaj sayfasına gönderiyor.
    return conversation;
  }

  Future<String> uploadGroupPP(ImageSource source) async {
    var pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile == null) throw ('DÜZGÜN SEÇİM YAPILMADI');

    var file = await _storageService.uploadFile(File(pickedFile.path));

    mediaUrl = await file.getDownloadURL();

    return mediaUrl;
  }
}
