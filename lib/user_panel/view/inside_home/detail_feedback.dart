import 'package:app_pengaduan_masyarakat_bna/shared/util/my_color.dart';
import 'package:flutter/material.dart';
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
          elevation: 0,
          title: Text(
            'Detail Aduan',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: "#FFBF00".toColor(),
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
              color: "#FFBF00".toColor(),
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
}
