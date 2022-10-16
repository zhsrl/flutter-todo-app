import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseStorageManager {
  String? downloadUrl;

  Future getData() async {
    try {
      await getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }

  Future<void> getDownloadURL() async {
    downloadUrl = await FirebaseStorage.instance
        .ref()
        .child("user_avatars")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .getDownloadURL();

    debugPrint(downloadUrl);
  }
}
