import 'package:app_pengaduan_masyarakat_bna/firebase_options.dart';
import 'package:app_pengaduan_masyarakat_bna/setup.dart';
import 'package:app_pengaduan_masyarakat_bna/intro_screen/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: splash(),
    ),
  );
}
