import 'dart:io';

import 'package:blog_web/core/utils/classes/creds.dart';
import 'package:blog_web/data/models/cuisine.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'abstract.dart';

class RemoteDatasourceImpl implements RemoteDatasource {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  final itemsCollection = FirebaseFirestore.instance.collection('cuisines');

  @override
  Future<void> addCuisine(CuisineModel cuisine, String imageUrl) async {
    final docRef = db.collection('cuisines').doc();
    cuisine.uid = docRef.id;
    cuisine.image = imageUrl;

    Future<bool> isDuplicateItem(String title) async {
      final snapshot = await itemsCollection
          .where('title', isEqualTo: title.toLowerCase())
          .get();
      return snapshot.docs.isNotEmpty;
    }

    final isDuplicate = await isDuplicateItem(cuisine.title.toLowerCase());
    if (isDuplicate) {
      print('item alreadt exist!');
    } else {
      await docRef
          .set(cuisine.toMap())
          .then((value) => print('Item added successfully!'));
    }
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

  @override
  Future<void> login(DTOsCredential creds) async {
    await auth.signInWithEmailAndPassword(
      email: creds.email,
      password: creds.password,
    );
  }

  @override
  Stream<User?> streamUser() => auth.authStateChanges();

  @override
  Stream<List<CuisineModel>> streamCuisines() {
    return db.collection('cuisines').snapshots().map((event) =>
        event.docs.map((e) => CuisineModel.fromJson(e.data())).toList());
  }

  @override
  Future<void> deleteCuisine(String uid) async {
    await db.collection('cuisines').doc(uid).delete();
  }

  @override
  Future<void> updateCuisine(String uid, CuisineModel cuisine) async {
    await db.collection('cuisines').doc(uid).update(cuisine.toMap());
  }
}
