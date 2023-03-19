import 'package:app_pengaduan_masyarakat_bna/shared/util/my_color.dart';
import 'package:flutter/material.dart';

class detail_view extends StatefulWidget {
  var detail;

  detail_view({this.detail, super.key});

  @override
  State<detail_view> createState() => _detail_viewState();
}

class _detail_viewState extends State<detail_view> {
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
          backgroundColor: "#2E4053".toColor()),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: content(),
      ),
    );
  }

  Widget content() {
    return Center(
      child: PhysicalModel(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 10, 10),
          width: double.infinity,
          height: 600,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Text(
                  widget.detail['username'],
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: Image.network(widget.detail['image']).image)),
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  "lokasi : ${widget.detail['lokasi']}",
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 15),
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
                child: Text(
                  widget.detail['deskripsi'],
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
