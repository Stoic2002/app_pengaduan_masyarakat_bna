import 'dart:io';

import 'package:app_pengaduan_masyarakat_bna/shared/util/my_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  String? uName = "";
  String? uEmail = "";
  String? uPhone = "";
  String? uImage = "";
  String? uId = "";
  String imgUrl = "";

  Future<void> getData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          uName = snapshot.data()!['username'];
          uEmail = snapshot.data()!['email'];
          uPhone = snapshot.data()!['nomor telepon'];
          uImage = snapshot.data()!['image'];
          uId = snapshot.data()!['user id'];
        });
      }
    });
  }

  Future<void> uploadImg() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? img = await _picker.pickImage(source: ImageSource.gallery);

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference ref = FirebaseStorage.instance.ref().child("profiles");
    Reference imgUpload = ref.child(fileName);

    try {
      await imgUpload.putFile(File(img!.path));

      imgUrl = await imgUpload.getDownloadURL();
      print(imgUrl);
    } catch (error) {}

    Reference refImg = FirebaseStorage.instance.refFromURL(imgUrl);
    refImg.delete();

    if (refImg == "") {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({"image": imgUrl});
    } else {}
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: "#2E4053".toColor(),
      ),
      body: Container(
        child: Center(
          child: content(),
        ),
      ),
    );
  }

  Widget content() {
    return Container(
      padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Column(children: [
              Container(
                child: CircleAvatar(
                  radius: 85.0,
                  backgroundColor: Colors.grey,
                  backgroundImage: uImage == null
                      ? Image.asset("assets/images/test.jpg").image
                      : Image.network(uImage!).image,
                ),
              ),
              Container(
                  child: ElevatedButton(
                onPressed: uploadImg,
                child: Icon(Icons.photo_camera),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>("#85929E".toColor())),
              ))
            ]),
          ),
          PhysicalModel(
            color: "#fee5b1".toColor(),
            elevation: 3,
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: EdgeInsets.all(20.0),
              width: double.infinity,
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      child: Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: "#ffcc00".toColor(),
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        uName!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 20,
                        ),
                      ),
                    ],
                  )),
                  Container(
                      child: Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        color: "#ffcc00".toColor(),
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        uEmail!,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  )),
                  Container(
                      child: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: "#ffcc00".toColor(),
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        uPhone!,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
