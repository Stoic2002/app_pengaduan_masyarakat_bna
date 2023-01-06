import 'package:app_pengaduan_masyarakat_bna/shared/util/my_color.dart';

import 'package:app_pengaduan_masyarakat_bna/user_panel/view/inside_home/list_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class aduan_terbaru extends StatefulWidget {
  const aduan_terbaru({super.key});

  @override
  State<aduan_terbaru> createState() => _aduan_terbaruState();
}

class _aduan_terbaruState extends State<aduan_terbaru> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference data = firestore.collection("aduan");
    return data.orderBy("tanggal", descending: true).snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: "#E74C3C".toColor(),
        title: Text(
          'Aduan Terbaru',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 15, right: 15),
        color: "#943126".toColor(),
        child: content(),
      ),
    );
  }

  Widget content() {
    return StreamBuilder<QuerySnapshot<Object?>>(
        stream: streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listAllDocument = snapshot.data!.docs;
            return list_view(listAllDocument);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
