import 'dart:developer';

import 'package:app_pengaduan_masyarakat_bna/intro_screen/login.dart';
import 'package:app_pengaduan_masyarakat_bna/intro_screen/services/register_service.dart';
import 'package:app_pengaduan_masyarakat_bna/shared/util/my_color.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController userNameCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController noTelpCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();

  String role = "user";

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
      height: 650,
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Text(
                  "Pendaftaran",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: TextFormField(
                  controller: userNameCon,
                  decoration: InputDecoration(
                      label: Text('Nama akun',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "masukkan nama akun";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                child: TextFormField(
                  controller: emailCon,
                  decoration: InputDecoration(
                      label: Text('Email',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
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
                child: TextFormField(
                  controller: noTelpCon,
                  keyboardType: TextInputType.numberWithOptions(),
                  maxLength: 13,
                  decoration: InputDecoration(
                      label: Text('Nomor Telepon',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[0-9]{13}$').hasMatch(value)) {
                      return "masukkan nomor telepon yang benar";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                child: TextFormField(
                    controller: passwordCon,
                    obscureText: true,
                    decoration: InputDecoration(
                        label: Text('Password',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                    validator: _requeiredConfirmValidator),
              ),
              Container(
                child: TextFormField(
                  decoration: InputDecoration(
                      label: Text('Verifikasi Password',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          )),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                  validator: _requeiredConfirmValidator,
                ),
              ),
              Container(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all("#6495ED".toColor()),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ))),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addData();
                    }
                  },
                  child: Text('Register',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Sudah punya akun? ',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: "#40E0D0".toColor(), fontFamily: 'Poppins'),
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  void addData() async {
    User? user = FirebaseAuth.instance.currentUser;
    final auth = FirebaseAuth.instance;

    var uName = userNameCon.text;
    var uEmail = emailCon.text.trim();
    var uNoTelp = noTelpCon.text.trim();
    var uPass = passwordCon.text.trim();

    final List<String> loginMethod =
        await auth.fetchSignInMethodsForEmail(uEmail);
    if (loginMethod.isEmpty) {
      await auth
          .createUserWithEmailAndPassword(
            email: uEmail,
            password: uPass,
          )
          .then((value) => {
                registerUser(uName, uEmail, uNoTelp, uPass, role),
                showSignUpSuccessDialog()
              });
    } else {
      log('email already taken');
    }
  }

  void showSignUpSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Sign Up Success',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Your account has been created successfully.',
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
                FirebaseAuth.instance.signOut();
                Get.to(login());
              },
            ),
          ],
        );
      },
    );
  }

  String? _requeiredConfirmValidator(String? confirmPasswordText) {
    if (confirmPasswordText == null || confirmPasswordText.trim().isEmpty) {
      return 'Form ini dibutuhkan !';
    }
    if (passwordCon.text != confirmPasswordText) {
      return 'Password tidak sama';
    } else {
      return null;
    }
  }
}
