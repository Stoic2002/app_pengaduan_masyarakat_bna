import 'package:app_pengaduan_masyarakat_bna/shared/util/my_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'package:timeline_tile/timeline_tile.dart';

class detail_item_admin extends StatefulWidget {
  var detail;
  // String aduanId;
  detail_item_admin({this.detail, super.key});

  @override
  State<detail_item_admin> createState() => _detail_item_adminState();
}

class _detail_item_adminState extends State<detail_item_admin> {
  bool _isCompleted = false;
  int _currentStep = 0;
  // final mq = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
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
              height: 1000,
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
                height: 400,
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        'Progres Aduan',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          // color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                        child: Column(
                      children: [
                        SizedBox(
                            width: 250,
                            height: 100,
                            child: TimelineTile(
                              afterLineStyle: LineStyle(
                                color: _currentStep == 1
                                    ? Colors.lightBlue
                                    : Colors.grey,
                              ),
                              indicatorStyle: IndicatorStyle(
                                  iconStyle: IconStyle(
                                      iconData: _isCompleted
                                          ? Icons.check
                                          : Icons.circle,
                                      color: Colors.white),
                                  color: _currentStep == 0
                                      ? Colors.lightBlue
                                      : Colors.grey,
                                  width: 30,
                                  height: 30),
                              endChild: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'aduan sudah diverifikasi',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.white,
                                  ),
                                ),
                              ),
                              isFirst: true,
                              isLast: false,
                            )),
                        SizedBox(
                          width: 250,
                          height: 100,
                          child: TimelineTile(
                            // afterLineStyle: LineStyle(color: Colors.lightBlue),
                            // beforeLineStyle: LineStyle(color: Colors.lightBlue),
                            indicatorStyle: IndicatorStyle(
                              // color: Colors.lightBlue,
                              width: 30,
                              height: 30,
                            ),
                            endChild: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                'Masalah sedang diselesaikan',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  // color: Colors.white,
                                ),
                              ),
                            ),
                            isFirst: false,
                            isLast: false,
                          ),
                        ),
                        SizedBox(
                            width: 250,
                            height: 100,
                            child: TimelineTile(
                              // beforeLineStyle:
                              //     LineStyle(color: Colors.lightBlue),
                              indicatorStyle: IndicatorStyle(
                                  // color: Colors.lightBlue,
                                  width: 30,
                                  height: 30),
                              isFirst: false,
                              isLast: true,
                              endChild: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'done',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.white,
                                  ),
                                ),
                              ),
                            )),
                      ],
                    )),
                    Container(
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              // _currentStep >= 1
                              //     ? _currentStep += 1
                              //     : _currentStep = 0;
                              // _isCompleted = true;
                              verificationShow();
                            });
                          },
                          child: Text('Verifikasi')),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TextEditingController progres1 = new TextEditingController();
  TextEditingController progres2 = new TextEditingController();
  TextEditingController progres3 = new TextEditingController();

  void verificationShow() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Verifikasi progres'),
          content: Form(
            // key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  controller: progres1,
                  decoration: InputDecoration(labelText: 'Progres 1'),
                ),
                TextFormField(
                  controller: progres2,
                  decoration: InputDecoration(labelText: 'Progres 2'),
                ),
                TextFormField(
                  controller: progres3,
                  decoration: InputDecoration(labelText: 'Progres 3'),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text('Batal'),
              onPressed: () {
                Get.back();
              },
            ),
            ElevatedButton(
              child: Text('Simpan'),
              onPressed: () async {
                // final ref = await FirebaseFirestore.instance
                //     .collection('aduan')
                //     .where('image')
                //     .get()
                //     .then((value) => addData());
                addData();

                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  // User? user = FirebaseAuth.instance.currentUser;

  Future<void> addData() async {
    FirebaseFirestore.instance
        .collection('aduan')
        .doc(widget.detail['aduanid'])
        .collection('feedback')
        .add({
      "progres 1": progres1.text,
      "progres 2": progres2.text,
      "progres 3": progres3.text,
    });
  }
}
