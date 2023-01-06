import 'package:app_pengaduan_masyarakat_bna/shared/util/my_color.dart';

import 'package:app_pengaduan_masyarakat_bna/user_panel/view/inside_home/aduan_terbaru.dart';
import 'package:app_pengaduan_masyarakat_bna/user_panel/view/inside_home/feedback.dart';
import 'package:app_pengaduan_masyarakat_bna/user_panel/view/inside_home/profile.dart';
import 'package:app_pengaduan_masyarakat_bna/user_panel/view/inside_home/tambah_aduan.dart';
import 'package:app_pengaduan_masyarakat_bna/intro_screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: "#6495ED".toColor(),
        leading: Text(''),
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
      body: Container(
        color: "#6495ED".toColor(),
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Center(child: content()),
      ),
    );
  }

  Widget content() {
    return Container(
      height: 600,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat Datang, ',
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Poppins', fontSize: 25, color: Colors.white),
              ),
              Text(
                'di aplikasi pengaduan masyarakat',
                style: TextStyle(
                    fontFamily: 'Poppins', fontSize: 25, color: Colors.white),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                    'Di platform ini anda dapat melaporkan keluhan terkait fasilitas publik',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.white)),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: PhysicalModel(
              color: "#EAECEE".toColor(),
              elevation: 3,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: Container(
                width: double.infinity,
                height: 350,
                child: GridView.count(
                  padding: EdgeInsets.all(35.0),
                  crossAxisCount: 2,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 20,
                  // physics: NeverScrollableScrollPhysics(),
                  children: [
                    InkWell(
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => tambah_aduan());
                          Navigator.of(context).push(route);
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.add_circle,
                                  size: 60,
                                  color: "#DE3163".toColor(),
                                ),
                                Text(
                                  'Tambah Aduan',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ))),
                    InkWell(
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => aduan_terbaru());
                          Navigator.of(context).push(route);
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.note_add,
                                  size: 60,
                                  color: "#FF7F50".toColor(),
                                ),
                                Text(
                                  'Aduan Terbaru',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ))),
                    InkWell(
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => feedback());
                          Navigator.of(context).push(route);
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.feedback_outlined,
                                  size: 60,
                                  color: "#FFBF00".toColor(),
                                ),
                                Text(
                                  'Feedback',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ))),
                    InkWell(
                        onTap: () {
                          Route route = MaterialPageRoute(
                              builder: (context) => profile());
                          Navigator.of(context).push(route);
                        },
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            elevation: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.person_outline_sharp,
                                  size: 65,
                                  color: "#DFFF00".toColor(),
                                ),
                                Text(
                                  'Profile',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ))),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
