import 'package:app_pengaduan_masyarakat_bna/shared/util/my_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DetailAduanAdmin extends StatefulWidget {
  var detail;
  DetailAduanAdmin({this.detail, super.key});

  @override
  State<DetailAduanAdmin> createState() => _DetailAduanAdminState();
}

class _DetailAduanAdminState extends State<DetailAduanAdmin> {
  bool progress1 = false;
  bool progress2 = false;
  bool progress3 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            'Detail Aduan',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: "#8E44AD".toColor(),
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              height: 900,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(top: 10, right: 15, left: 15),
              color: "#5B2C6F".toColor(),
              child: content(),
            ),
          ),
        ));
  }

  Widget content() {
    return PhysicalModel(
      borderRadius: BorderRadius.circular(30),
      elevation: 3,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 10, 10, 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.network(widget.detail['image']).image)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    widget.detail['judul'],
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    widget.detail['deskripsi'],
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                  ),
                ),
                Container(
                  // margin: EdgeInsets.only(top: 40),
                  // padding: EdgeInsets.only(top: 50),
                  child: Text(
                    "Lokasi : ${widget.detail['lokasi']}",
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                  ),
                ),
                Container(
                  child: Text(
                    "Pelapor : ${widget.detail['username']}",
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 1.5,
                width: double.infinity,
                color: Colors.black,
              ),
            ),
            PhysicalModel(
              color: "#D2B4DE".toColor(),
              borderRadius: BorderRadius.circular(20),
              elevation: 3,
              child: Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Text(
                        'Verifikasi',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              child: Checkbox(
                                activeColor: Colors.green,
                                value: progress1,
                                onChanged: (value) {
                                  setState(() {
                                    progress1 = value!;
                                  });
                                  addCheckProgess1();
                                },
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                'Verifikasi aduan',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,

                                  // color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: Checkbox(
                                activeColor: Colors.green,
                                value: progress2,
                                onChanged: (value) async {
                                  if (widget.detail['progres 1'] != false) {
                                    setState(() {
                                      progress2 = value!;
                                    });
                                    addCheckProgess2();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                'Masalah sedang diproses',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,

                                  // color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: Checkbox(
                                activeColor: Colors.green,
                                value: progress3,
                                onChanged: (value) {
                                  if (widget.detail['progres 1'] != false &&
                                      widget.detail['progres 2'] != false) {
                                    setState(() {
                                      progress3 = value!;
                                    });
                                    addCheckProgess3();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                'Masalah terselsaikan',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,

                                  // color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    dataProgress();
  }

  Future<void> dataProgress() async {
    await FirebaseFirestore.instance
        .collection('aduan')
        .doc(widget.detail['aduanid'])
        .get()
        .then((snap) {
      if (snap.exists) {
        setState(() {
          progress1 = snap.get('progres 1');
          progress2 = snap.get('progres 2');
          progress3 = snap.get('progres 3');
        });
      }
    });
  }

  // User? user = FirebaseAuth.instance.currentUser;

  Future<void> addCheckProgess1() async {
    await FirebaseFirestore.instance
        .collection("aduan")
        .doc(widget.detail['aduanid'])
        .update({'progres 1': progress1});
  }

  Future<void> addCheckProgess2() async {
    await FirebaseFirestore.instance
        .collection("aduan")
        .doc(widget.detail['aduanid'])
        .update({'progres 2': progress2});
  }

  Future<void> addCheckProgess3() async {
    await FirebaseFirestore.instance
        .collection("aduan")
        .doc(widget.detail['aduanid'])
        .update({'progres 3': progress3});
  }

  // .collection('feedback')
  // .snapshots();

  //     .add({
  //   "progres 1": progres1.text,
  //   "progres 2": progres2.text,
  //   "progres 3": progres3.text,
  // });
}
