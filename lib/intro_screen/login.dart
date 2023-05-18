import 'package:app_pengaduan_masyarakat_bna/admin_panel/view/dashboard_admin.dart';
import 'package:app_pengaduan_masyarakat_bna/admin_panel/view/home_admin.dart';
import 'package:app_pengaduan_masyarakat_bna/shared/util/my_color.dart';
import 'package:app_pengaduan_masyarakat_bna/user_panel/view/dashboard_user.dart';

import 'package:app_pengaduan_masyarakat_bna/user_panel/view/home.dart';
import 'package:app_pengaduan_masyarakat_bna/intro_screen/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // openHome();
  }

  @override
  void dispose() {
    emailCon.dispose();
    passCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: "#2E4053".toColor(),
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Center(child: content()),
      ),
    );
  }

  Widget content() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                  'Platform Layanan Pengaduan Banjarnegara',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              PhysicalModel(
                borderRadius: BorderRadius.circular(20),
                elevation: 2,
                color: Colors.white,
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 380,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                              child: Image.asset(
                                'assets/images/logo.png',
                                height: 50,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              child: TextFormField(
                                controller: emailCon,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.person_outline),
                                    label: Text('Email',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                        )),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "masukkan email";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                obscureText: true,
                                controller: passCon,
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.lock),
                                    label: Text('Password',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                        )),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "masukkan password";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 75,
                              padding: EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        "#85929E".toColor()),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ))),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    loginAuth();
                                  }
                                },
                                child: Text('Login',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        PhysicalModel(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          elevation: 2,
          color: Colors.white,
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Belum punya akun? ',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    )),
                InkWell(
                  onTap: () {
                    Get.to(register());
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: "#40E0D0".toColor(), fontFamily: 'Poppins'),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void loginAuth() async {
    var loginEmail = emailCon.text.trim();
    var loginPass = passCon.text.trim();

    try {
      final User? firebaseUser =
          (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginEmail,
        password: loginPass,
      ))
              .user;
      if (firebaseUser != null) {
        route();
      }
    } on FirebaseException catch (e) {
      print(e.message);
      // Get.defaultDialog(
      //   title: "Gagal Login",
      //   middleText: "Email atau kata sandi salah",
      //   onConfirm: () {
      //     Get.back();
      //   },
      //   textConfirm: "Okey",
      // );
      loginFailed();
    }
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        if (documentSnapshot.get('role') == "admin") {
          Get.off(home_admin());
        } else {
          Get.off(DashboardUser());
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  void loginFailed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Gagal login',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'username atau password salah',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
