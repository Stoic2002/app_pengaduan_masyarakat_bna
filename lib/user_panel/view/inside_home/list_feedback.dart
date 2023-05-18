import 'package:app_pengaduan_masyarakat_bna/user_panel/view/inside_home/detail_feedback.dart';
import 'package:flutter/material.dart';

class list_feedback extends StatelessWidget {
  var listAllDocs;
  list_feedback({this.listAllDocs, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listAllDocs.length,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                var detail = listAllDocs[index].data() as Map<String, dynamic>;

                Route route = MaterialPageRoute(
                    builder: (context) => detail_feedback(
                          detail: detail,
                        ));
                Navigator.push(context, route);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
                width: MediaQuery.of(context).size.width,
                height: 145,
                decoration: BoxDecoration(
                  color: Colors.white,
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    // ignore: prefer_const_constructors
                    BoxShadow(
                      blurRadius: 6,
                      color: Color(0x34000000),
                      offset: Offset(0, 3),
                    )
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.network(
                                      '${(listAllDocs[index].data() as Map<String, dynamic>)["image"]}')
                                  .image)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 230,
                          child: Text(
                            "${(listAllDocs[index].data() as Map<String, dynamic>)["judul"]}",
                            style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          width: 230,
                          child: Text(
                            "${(listAllDocs[index].data() as Map<String, dynamic>)["deskripsi"]}",
                            style: TextStyle(
                                fontSize: 16.0, fontFamily: 'Poppins'),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: 230,
                          child: Text(
                            "${(listAllDocs[index].data() as Map<String, dynamic>)["lokasi"]}",
                            style: TextStyle(
                                fontSize: 14.0, fontFamily: 'Poppins'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: 220,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(""),
                              listAllDocs[index].data()['progres 1'] != false
                                  ? Row(
                                      children: [
                                        Text("Verified",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0,
                                                fontFamily: 'Poppins'),
                                            maxLines: 1),
                                        Icon(
                                          Icons.verified,
                                          color: Colors.lightBlue,
                                        )
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        )
                      ],
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
}
