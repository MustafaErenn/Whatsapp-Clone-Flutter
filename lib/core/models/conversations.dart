import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp_clone_flutter/core/models/profile.dart';

class Conversation {
  String id;
  String name;
  String profileImage;
  String displayMessage;

  Conversation({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.displayMessage,
  });

  factory Conversation.fromSnapshot(
      DocumentSnapshot snapshot, Profile profile) {
    return Conversation(
        id: snapshot.id,
        name: profile.name + ' ' + profile.surname,
        profileImage: profile.pp,
        displayMessage: snapshot.get('displayMessage'));
  }
}
