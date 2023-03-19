import 'package:app_pengaduan_masyarakat_bna/admin_panel/view/home_admin.dart';
import 'package:app_pengaduan_masyarakat_bna/user_panel/view/dashboard_user.dart';
import 'package:app_pengaduan_masyarakat_bna/user_panel/view/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  User? user;
  String? role = "";
  @override
  void initState() {
    // TODO: implement initState
    user = FirebaseAuth.instance.currentUser;
    super.initState();
    openLogin();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
              Image.asset('assets/images/logo.png', height: 180, width: 180)),
    );
  }

  openLogin() {
    Future.delayed(const Duration(seconds: 2)).then((value) async {
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get()
            .then((DocumentSnapshot snap) {
          if (snap.exists) {
            if (snap.get('role') == 'admin') {
              Get.off(() => home_admin());
            } else if (snap.get('role') == 'user') {
              Get.off(() => DashboardUser());
            }
          }
        });
      } else {
        Get.off(login());
      }
    });
  }
}
