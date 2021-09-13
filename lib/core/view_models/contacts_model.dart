import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:whatsapp_clone_flutter/core/models/conversations.dart';
import 'package:whatsapp_clone_flutter/core/models/profile.dart';
import 'package:whatsapp_clone_flutter/core/services/firestore_db.dart';

class ContactsModel with ChangeNotifier {
  final FirestoreDB _db = GetIt.instance<FirestoreDB>();
  Future<List<Profile>> getContacts(String? query) async {
    var contacts = await _db.getContacts();

    var filteredContacts = contacts.where((profile) =>
        (profile.name.startsWith(query ?? "") &&
            profile.userId != FirebaseAuth.instance.currentUser!.uid));

    return filteredContacts.toList();
  }

  Future<Conversation> startConversation(User user, Profile profile) async {
    var result = await FirebaseFirestore.instance
        .collection('conversations')
        .where('members', arrayContains: user.uid)
        .get()
        .then((snapshot) => snapshot.docs);

    for (var i = 0; i < result.length; i++) {
      if (listEquals(
          result[i].get('members'), <dynamic>[user.uid, profile.userId])) {
        return Conversation(
            id: result[i].id,
            displayMessage: '',
            name: (profile.name + ' ' + profile.surname),
            profileImage: profile.pp);
      }
    }
    var conversation = await _db.startConversation(user, profile);
    return conversation;
  }
}
