// import 'package:app_pengaduan_masyarakat_bna/admin_panel/view/home_admin.dart';
// import 'package:app_pengaduan_masyarakat_bna/user_panel/view/home.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class screen_manage extends StatelessWidget {
//   const screen_manage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final Stream<QuerySnapshot> _usersStream =
//         FirebaseFirestore.instance.collection('users').snapshots();
//     return StreamBuilder<QuerySnapshot>(
//       stream: _usersStream,
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         snapshot.data!.docs.map((DocumentSnapshot snap) {
//           Map<String, dynamic> data = snap.data()! as Map<String, dynamic>;
//           if (snap['role'] == 'admin') {
//             home_admin();
//           } else {
//             home();
//           }

//           return CircularProgressIndicator();
//         });
//       },
//     );
//   }
// }
