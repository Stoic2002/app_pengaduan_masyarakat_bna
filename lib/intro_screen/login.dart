import 'package:app_pengaduan_masyarakat_bna/admin_panel/view/home_admin.dart';
import 'package:app_pengaduan_masyarakat_bna/shared/util/my_color.dart';

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
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Center(child: content()),
      ),
    );
  }

  Widget content() {
    return Container(
      height: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Container(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 60,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'Platform Layanan Pengaduan Banjarnegara',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 24),
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
                          borderRadius: BorderRadius.circular(30))),
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
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              Container(
                width: double.infinity,
                height: 75,
                padding: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all("#6495ED".toColor()),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ))),
                  onPressed: loginAuth,
                  child: Text('Login',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Belum punya akun? ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        )),
                    InkWell(
                      onTap: () {
                        Route route =
                            MaterialPageRoute(builder: (context) => register());
                        Navigator.of(context).push(route);
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                            color: "#40E0D0".toColor(), fontFamily: 'Poppins'),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void loginAuth() async {
    // FutureBuilder(

    //   future: getData(),
    //   builder:  (context, snapshot) {
    //     if (snapshot.hasData){
    //       setState(() {
    //        return role = snapshot.data['role'];
    //       });
    //     }
    //   }

    //   );

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
        // Route route = MaterialPageRoute(builder: (context) => home());
        // Navigator.pushReplacement(context, route);
        // if (role == "admin") {
        //   Get.off(home_admin());
        // }
      }
    } on FirebaseException catch (e) {
      print(e.message);
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
          Get.off(home());
        }
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  User? user = FirebaseAuth.instance.currentUser;

  // openHome() {
  //   Future.delayed(const Duration(seconds: 0)).then((value) async {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(user!.uid)
  //         .get()
  //         .then((DocumentSnapshot snap) {
  //       if (snap.exists) {
  //         if (user != null && snap.get('role') == 'admin') {
  //           Get.off(() => home_admin());
  //         } else if (user != null && snap.get('role') == 'user') {
  //           Get.off(() => home());
  //         }
  //       }
  //     });
  //   });
  // }
}
