import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsapp_clone_flutter/core/services/locator.dart';
import 'package:whatsapp_clone_flutter/core/services/storage_service.dart';

class ConversationModel extends ChangeNotifier {
  final StorageService _storageService = getIt<StorageService>();
  String mediaUrl = '';
  late CollectionReference _ref;
  bool isGroup = false;
  String nameAndSurname = '';

  groupCheck(String id) async {
    var docRef =
        await FirebaseFirestore.instance.collection('groups').doc('$id').get();

    isGroup = docRef.exists;
    notifyListeners();
  }

  Stream<QuerySnapshot> getConversation(String id) {
    getCurrentPersoName();
    _ref = FirebaseFirestore.instance
        .collection('conversations')
        .doc('$id')
        .collection('messages');

    return _ref.orderBy('timeStamp', descending: false).snapshots();
  }

  Stream<QuerySnapshot> getConversationGroups(String id) {
    getCurrentPersoName();
    _ref = FirebaseFirestore.instance
        .collection('groups')
        .doc('$id')
        .collection('messages');

    return _ref.orderBy('timeStamp', descending: false).snapshots();
  }

  Future add(Map<String, dynamic> dialogMap, String id) async {
    await _ref.add(dialogMap);
    mediaUrl = '';
    notifyListeners();
  }

  getCurrentPersoName() async {
    var user = await FirebaseFirestore.instance
        .collection('Accounts')
        .doc(FirebaseAuth.instance.currentUser!.uid.toString())
        .get();

    nameAndSurname = user.get('name') + ' ' + user.get('surname');
    notifyListeners();
  }

  Future addToGroups(Map<String, dynamic> dialogMap, String id) async {
    await FirebaseFirestore.instance
        .collection('groups')
        .doc('$id')
        .collection('messages')
        .add(dialogMap);
    mediaUrl = '';
    notifyListeners();
  }

  uploadMedia(ImageSource source) async {
    var pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile == null) return;

    var file = await _storageService.uploadFile(File(pickedFile.path));

    mediaUrl = await file.getDownloadURL();
    await _ref.add({
      'senderId': FirebaseAuth.instance.currentUser!.uid.toString(),
      'message': '',
      'timeStamp': DateTime.now(),
      'mediaUrl': mediaUrl,
    });
    notifyListeners();
  }
}
