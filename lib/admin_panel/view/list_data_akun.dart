import 'package:app_pengaduan_masyarakat_bna/admin_panel/view/list_item_akun.dart';
import 'package:app_pengaduan_masyarakat_bna/shared/util/my_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListDataAkun extends StatefulWidget {
  const ListDataAkun({super.key});

  @override
  State<ListDataAkun> createState() => _ListDataAkunState();
}

class _ListDataAkunState extends State<ListDataAkun> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference data = firestore.collection("users");
    return data.where('role', isEqualTo: 'user').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 15, right: 15),
        color: "#5B2C6F".toColor(),
        child: content(),
      ),
    );
  }

  Widget content() {
    return StreamBuilder<QuerySnapshot<Object?>>(
        stream: streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            var listDocs = snapshot.data!.docs;
            return ListItemAkun(
              listAllDocs: listDocs,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
