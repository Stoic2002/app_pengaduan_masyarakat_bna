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
  bool isCheked = false;
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
                        'Verifikasi',
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
                                  color: widget.detail['progres 2'] == ""
                                      ? Colors.grey
                                      : Colors.lightBlue),
                              indicatorStyle: IndicatorStyle(
                                  iconStyle: IconStyle(
                                      iconData: widget.detail['progres 1'] != ""
                                          ? Icons.check
                                          : Icons.circle,
                                      color: Colors.white),
                                  color: widget.detail['progres 1'] == ""
                                      ? Colors.grey
                                      : Colors.lightBlue,
                                  width: 30,
                                  height: 30),
                              endChild: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  widget.detail['progres 1'],
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
                            afterLineStyle: LineStyle(
                                color: widget.detail['progres 3'] == ""
                                    ? Colors.grey
                                    : Colors.lightBlue),
                            beforeLineStyle: LineStyle(
                                color: widget.detail['progres 2'] == ""
                                    ? Colors.grey
                                    : Colors.lightBlue),
                            indicatorStyle: IndicatorStyle(
                              iconStyle: IconStyle(
                                  iconData: widget.detail['progres 2'] != ""
                                      ? Icons.check
                                      : Icons.circle,
                                  color: Colors.white),
                              color: widget.detail['progres 2'] == ""
                                  ? Colors.grey
                                  : Colors.lightBlue,
                              width: 30,
                              height: 30,
                            ),
                            endChild: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                widget.detail['progres 2'],
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
                              beforeLineStyle: LineStyle(
                                  color: widget.detail['progres 3'] == ""
                                      ? Colors.grey
                                      : Colors.lightBlue),
                              indicatorStyle: IndicatorStyle(
                                  iconStyle: IconStyle(
                                      iconData: widget.detail['progres 3'] != ""
                                          ? Icons.check
                                          : Icons.circle,
                                      color: Colors.white),
                                  color: widget.detail['progres 3'] == ""
                                      ? Colors.grey
                                      : Colors.lightBlue,
                                  width: 30,
                                  height: 30),
                              isFirst: false,
                              isLast: true,
                              endChild: Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  widget.detail['progres 3'],
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

  TextEditingController progres1 = TextEditingController();
  TextEditingController progres2 = TextEditingController();
  TextEditingController progres3 = TextEditingController();
  void textProgress() {
    setState(() {
      progres1.text = widget.detail['progres 1'];
      progres2.text = widget.detail['progres 2'];
      progres3.text = widget.detail['progres 3'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    textProgress();
  }

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
                  maxLength: 50,
                  controller: progres1,
                  decoration: InputDecoration(
                    labelText: 'Progres 1',
                  ),
                ),
                TextFormField(
                  maxLength: 50,
                  controller: progres2,
                  decoration: InputDecoration(
                    labelText: 'Progres 2',
                  ),
                ),
                TextFormField(
                  maxLength: 30,
                  controller: progres3,
                  decoration: InputDecoration(
                    labelText: 'Progres 3',
                  ),
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
    final progress = FirebaseFirestore.instance
        .collection('aduan')
        .doc(widget.detail['aduanid'])
        .update({
      "progres 1": progres1.text,
      "progres 2": progres2.text,
      "progres 3": progres3.text,
    });

    // Future<void> addCheckValue() async {
    //   await FirebaseFirestore.instance
    //       .collection("aduan")
    //       .doc(widget.detail['aduanid'])
    //       .update({'checkbox': isCheked});
    // }
    
    // .collection('feedback')
    // .snapshots();

    //     .add({
    //   "progres 1": progres1.text,
    //   "progres 2": progres2.text,
    //   "progres 3": progres3.text,
    // });
  }
}
