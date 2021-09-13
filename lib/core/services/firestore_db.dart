import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:whatsapp_clone_flutter/core/models/conversations.dart';
import 'package:whatsapp_clone_flutter/core/models/profile.dart';

class FirestoreDB {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Conversation>> getConversations(String userId) {
    var ref = _firestore
        .collection('conversations')
        .where('members', arrayContains: userId);

    var conversations = ref.snapshots();

    var profileStreams = getContacts().asStream();

    return Rx.combineLatest2(
        conversations,
        profileStreams,
        (QuerySnapshot conversations, List<Profile> profiles) =>
            conversations.docs.map((snapshot) {
              List<String> members = List.from(snapshot['members']);

              var profile = profiles.firstWhere((element) =>
                  element.userId ==
                  members.firstWhere((element) => element != userId));
              return Conversation.fromSnapshot(snapshot, profile);
            }).toList());
  }

  Stream<List<Conversation>> getGroups(String userId) {
    var groupsListStream = getGroupsList(userId).asStream();

    return groupsListStream;
  }

  Future<List<Conversation>> getGroupsList(String userId) async {
    var groupRef = await _firestore
        .collection('groups')
        .where('members', arrayContains: userId)
        .get();
    List<Conversation> groups = [];
    groupRef.docs.forEach((element) {
      groups.add(Conversation(
          id: element.id,
          name: element.get('groupName'),
          profileImage: element.get('groupPP'),
          displayMessage: ''));
    });

    return groups;
  }

  Future<List<Profile>> getContacts() async {
    var ref = _firestore.collection('Accounts');

    var documents = await ref.get();

    return documents.docs
        .map((snapshot) => Profile.fromSnapshot(snapshot))
        .toList();
  }

  Future<Conversation> startConversation(User user, Profile profile) async {
    var _ref = _firestore.collection('conversations');

    var _documentRef = await _ref.add({
      'displayMessage': '',
      'members': [user.uid, profile.userId],
    });
    return Conversation(
        id: _documentRef.id,
        displayMessage: '',
        name: (profile.name + ' ' + profile.surname),
        profileImage: profile.pp);
  }

  Future<Conversation> startGroupConversation(
      List<String> members, String groupName, String ppUrl) async {
    var _ref = _firestore.collection('groups');
    members.add(FirebaseAuth.instance.currentUser!
        .uid); // seçtiği kullanıcalar yanına kendini ekliyor
    var _documentRef = await _ref.add({
      'groupName': groupName,
      'groupPP': ppUrl,
      'members': members,
    });
    return Conversation(
        id: _documentRef.id,
        displayMessage: '',
        name: groupName,
        profileImage: ppUrl);
  }
}
