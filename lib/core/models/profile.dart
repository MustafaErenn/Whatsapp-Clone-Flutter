import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String userId;
  String email;
  String name;
  String surname;
  String pp;
  Profile({
    required this.email,
    required this.userId,
    required this.name,
    required this.surname,
    required this.pp,
  });

  factory Profile.fromSnapshot(DocumentSnapshot snapshot) {
    return Profile(
        userId: snapshot.id,
        email: snapshot['email'],
        name: snapshot['name'],
        surname: snapshot['surname'],
        pp: snapshot['pp']);
  }
}
