import 'package:app_pengaduan_masyarakat_bna/intro_screen/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

registerUser(
  String uName,
  String uEmail,
  String uNoTelp,
  String uPass,
  String role,
) async {
  User? userid = FirebaseAuth.instance.currentUser;
  try {
    await FirebaseFirestore.instance.collection("users").doc(userid!.uid).set({
      "username": uName,
      "nomor telepon": uNoTelp,
      "email": uEmail,
      "created at": DateTime.now(),
      "user id": userid.uid,
      "role": role
    }).then((value) => {
          // FirebaseAuth.instance.signOut(),
          // Get.to(login()),
        });
  } on FirebaseAuthException catch (e) {
    // Get.defaultDialog();
  }
}
