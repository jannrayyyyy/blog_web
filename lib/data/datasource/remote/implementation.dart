import 'dart:io';

import 'package:blog_web/data/models/cuisine.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'abstract.dart';

class RemoteDatasourceImpl implements RemoteDatasource {
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  @override
  Future<void> addCuisine(CuisineModel cuisine, String imageUrl) async {
    final docRef = db.collection('cuisines').doc();
    cuisine.uid = docRef.id;
    cuisine.image = imageUrl;
    await docRef
        .set(cuisine.toMap())
        .then((value) => print("Item added successfully"));
  }

  @override
  Future<String> getDownloadUrl(String label, String path) async {
    String downloadUrl =
        await storage.ref().child('user/$label/$path').getDownloadURL();
    return downloadUrl;
  }

  @override
  Future<void> uploadImageToStorage(
    String label,
    XFile? file,
  ) async {
    if (kIsWeb) {
      Reference reference =
          FirebaseStorage.instance.ref().child('user/$label/${file?.name}');
      await reference.putData(
        await file!.readAsBytes(),
        SettableMetadata(
          contentType: 'image/jpeg',
        ),
      );
    } else {
      FirebaseStorage.instance
          .ref()
          .child('$label/${file?.name}')
          .putFile(File(file?.path ?? ''));
    }
  }
}
