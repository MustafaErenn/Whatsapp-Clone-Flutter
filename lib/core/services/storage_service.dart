import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future uploadFile(File file) async {
    var uploadTask = _firebaseStorage
        .ref()
        .child(
            'media/${DateTime.now().millisecondsSinceEpoch}.${file.path.split(".").last}')
        .putFile(file);

    var storageRef = await uploadTask.whenComplete(() {
      return uploadTask.snapshot;
    });

    return storageRef.ref;
  }
}
