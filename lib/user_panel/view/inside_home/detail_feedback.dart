import 'package:app_pengaduan_masyarakat_bna/shared/util/my_color.dart';
import 'package:app_pengaduan_masyarakat_bna/user_panel/view/inside_home/list_feedback.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

class detail_feedback extends StatefulWidget {
  var detail;

  detail_feedback({this.detail, super.key});

  @override
  State<detail_feedback> createState() => _detail_feedbackState();
}

class _detail_feedbackState extends State<detail_feedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              // Text(
              //   'hapus',
              // ),
              IconButton(
                onPressed: () {
                  if (widget.detail['progres 3'] != "") {
                    deleteData();
                    Get.back();
                  }
                },
                icon: widget.detail['progres 3'] == ""
                    ? Container()
                    : Icon(Icons.delete),
              )
            ],
            elevation: 0,
            title: Text(
              'Detail Aduan',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: "#2E4053".toColor()),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              height: 900,
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(top: 10, right: 15, left: 15),
              color: "#2E4053".toColor(),
              child: content(),
            ),
          ),
        ));
  }

  Widget content() {
    return PhysicalModel(
      elevation: 3,
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.network(widget.detail['image']).image)),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Lokasi : ${widget.detail['lokasi']}",
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 16),
                          ),
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
                            style:
                                TextStyle(fontFamily: 'Poppins', fontSize: 16),
                          ),
                        ),
                      ],
                    ))
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
              color: "#ffcc00".toColor(),
              elevation: 3,
              child: Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                height: 350,
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
    super.initState();
    snapData();
  }

  String aduanid = "";
  String imgUrl = "";

  void deleteData() {
    try {
      FirebaseFirestore.instance.collection('aduan').doc(aduanid).delete();
      Reference ref = FirebaseStorage.instance.refFromURL(imgUrl);
      ref.delete();
    } catch (e) {
      print(e);
    }
    print(aduanid);
    print(imgUrl);
  }

  void snapData() async {
    User? userid = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('aduan')
        .doc(widget.detail['aduanid'])
        .get()
        .then((snap) {
      if (snap.exists) {
        setState(() {
          aduanid = snap.get('aduanid');
          imgUrl = snap.get('image');
        });
      }
    });
  }
}
