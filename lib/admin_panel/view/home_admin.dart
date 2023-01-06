import 'package:app_pengaduan_masyarakat_bna/intro_screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class home_admin extends StatefulWidget {
  const home_admin({super.key});

  @override
  State<home_admin> createState() => _home_adminState();
}

class _home_adminState extends State<home_admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('admin'),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.deleteAll();
                Get.offAll(login());
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(),
    );
  }
}
