// ignore_for_file: unused_local_variable, avoid_print, body_might_complete_normally_nullable, use_build_context_synchronously

import 'dart:developer';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Api {
  static User get user => auth.currentUser!;

  //firebase authentication

  //firebase Authenthication

  static FirebaseAuth auth = FirebaseAuth.instance;

  //firebase database(cloud firestore)

  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //firebase Storage(Storage)

  static FirebaseStorage storage = FirebaseStorage.instance;

// firebase signIn

  static Future<User?> signIn(BuildContext context,
      {required String email, required String password}) async {
    try {
      User? user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
    } catch (e) {
      log('error $e');
      return null;
    }
  }

  static Future<User?> signUp(BuildContext context,
      {required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log('error $e');
      return null;
    }
  }

// firebase SignOut

  static Future signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      log('error $e');
    }
  }

//  image add to  firebase storage

  static Future<String> updateProfileImage(
      String childName, Uint8List file) async {
    Reference ref = storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // save data (cloud_firestore)

  static Future<String> saveData(
      {required String name, required Uint8List file}) async {
    try {
      if (name.isNotEmpty) {
        String imageUrl = await updateProfileImage('profileImage', file);
        await fireStore.collection('userProfile').add({
          'name': name,
          'imageUrl': imageUrl,
        });
      }
    } catch (e) {
      print('error :$e');
    }
    return 'error';
  }
}
