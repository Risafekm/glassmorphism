// ignore_for_file: unused_local_variable, avoid_print, body_might_complete_normally_nullable, use_build_context_synchronously

import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Api {
  static User get user => auth.currentUser!;

  //firebase authentication

  //firebase Authenthication

  static FirebaseAuth auth = FirebaseAuth.instance;

  //firebase database(cloud firestore)

  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

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
}
