import 'dart:convert';
import 'dart:io';

import 'package:app_pengaduan_masyarakat_bna/admin_panel/view/dashboard_admin.dart';
import 'package:app_pengaduan_masyarakat_bna/intro_screen/login.dart';
import 'package:app_pengaduan_masyarakat_bna/shared/util/my_color.dart';
import 'package:app_pengaduan_masyarakat_bna/user_panel/view/dashboard_user.dart';
import 'package:app_pengaduan_masyarakat_bna/user_panel/view/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class tambah_aduan extends StatefulWidget {
  const tambah_aduan({super.key});

  @override
  State<tambah_aduan> createState() => _tambah_aduanState();
}

class _tambah_aduanState extends State<tambah_aduan> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  User? userId;

  TextEditingController dateInput = TextEditingController();
  TextEditingController judulCon = TextEditingController();
  TextEditingController deskCon = TextEditingController();
  TextEditingController locCon = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  XFile? _img;
  String imgUrl = "";

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String? uName = "";

  Future<void> getData() async {
    await firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          uName = snapshot.data()!['username'];
        });
      }
    });
  }

  @override
  void initState() {
    userId = FirebaseAuth.instance.currentUser;
    dateInput.text = "";
    judulCon.text = "";
    deskCon.text = "";
    locCon.text = ""; //set the initial value of text field
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Tambah Aduan',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: "#34495E".toColor(),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.all(15.0),
        color: "#212F3C".toColor(),
        child: Center(
          child: content(),
        ),
      ),
    );
  }

  Widget content() {
    return Container(
        child: PhysicalModel(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      color: "#EAECEE".toColor(),
      elevation: 3,
      child: Container(
          padding: EdgeInsets.all(15.0),
          width: MediaQuery.of(context).size.width,
          height: 600,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: TextFormField(
                    controller: judulCon,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        label: Text('Judul',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        return null;
                      } else {
                        return "judul tidak boleh kosong";
                      }
                    },
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: deskCon,
                    maxLines: 4,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        label: Text('Deskripsi',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "deskripsi tidak boleh kosong";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Container(
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "tanggal tidak boleh kosong";
                      } else {
                        return null;
                      }
                    },
                    controller: dateInput,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                      label: Text('Tanggal',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          )),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: Icon(
                          color: Colors.lightBlue,
                          Icons.calendar_today_outlined),
                      //icon of text field
                      //label text of field
                    ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2022),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          dateInput.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: locCon,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        label: Text('Lokasi',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            )),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "lokasi tidak boleh kosong";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        enabled: false,
                        readOnly: true,
                        controller: _imageController,
                        decoration: InputDecoration(
                            hintText: 'foto belum diupload',
                            hintStyle: TextStyle(fontFamily: 'Poppins'),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ))),
                      ),
                    ),
                    Container(
                      height: 63,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all("#85929E".toColor()),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ))),
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          XFile? img = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (img != null) {
                            setState(() {
                              _img = img;
                            });
                            _imageController.text = img.name;
                          }
                        },
                        icon: Icon(Icons.photo_camera),
                        label: Text(
                          'Upload',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        // child: Text('Upload photo',
                        //     style: TextStyle(
                        //         fontFamily: 'Poppins',
                        //         fontSize: 20,
                        //         fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all("#2ECC71".toColor()),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addData(judulCon.text, deskCon.text, locCon.text,
                            dateInput.text, _img!);

                        showAddDataSuccessDialog();
                      }
                    },
                    child: Text('Tambah',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          )),
    ));
  }

  void addData(String judul, String deskripsi, String lokasi, String date,
      XFile image) async {
    // Future<String> tambahAduan(Map<String, dynamic> data) async {
    //   final docRef = await firestore.collection('aduan').add(data);
    //   return docRef.id;
    // }

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference ref = FirebaseStorage.instance.ref().child("images");
    Reference imgUpload = ref.child(fileName);

    try {
      await imgUpload.putFile(File(_img!.path));

      imgUrl = await imgUpload.getDownloadURL();
    } catch (error) {}

    final DocumentReference doc = await firestore.collection('aduan').add({
      "judul": judul,
      "deskripsi": deskripsi,
      "lokasi": lokasi,
      "tanggal": date,
      "image": imgUrl,
      "userid": userId!.uid,
      "username": uName!,
      "progres 1": false,
      "progres 2": false,
      "progres 3": false,
    });

    final String aduanid = doc.id;

    doc.update({'aduanid': aduanid});

    // await firestore
    //     .collection('aduan')
    //     .doc(aduanid)
    //     .collection('verifikasi')
    //     .doc()
    //     .set({
    //   "progress 1": "",
    //   "progress 2": "",
    //   "progress 3": "",
    // });
  }

  void showAddDataSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'data upload',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Data berhasil ditambahkan',
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
                Get.offAll(DashboardUser());
              },
            ),
          ],
        );
      },
    );
  }

  // void _selectImage() async {
  //   final ImagePicker _picker = ImagePicker();
  //   // Show the image picker and wait for the user to select an image.
  //   XFile? img = await _picker.pickImage(source: ImageSource.gallery);

  //   // If the user selected an image, display it and save it to the Firestore database.
  //   if (img != null) {
  //     setState(() {
  //       _img = img;
  //     });
  //   }
  // }
}
