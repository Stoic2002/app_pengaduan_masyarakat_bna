import 'package:app_pengaduan_masyarakat_bna/shared/util/my_color.dart';
import 'package:app_pengaduan_masyarakat_bna/user_panel/view/inside_home/detail_view.dart';
import 'package:flutter/material.dart';

class list_view extends StatelessWidget {
  var listAllDocument;

  list_view(this.listAllDocument, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listAllDocument.length,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                var detail =
                    listAllDocument[index].data() as Map<String, dynamic>;

                Route route = MaterialPageRoute(
                    builder: (context) => detail_view(
                          detail: detail,
                        ));
                Navigator.push(context, route);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 400,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: "#CCD1D1".toColor()),
                    bottom: BorderSide(color: "#CCD1D1".toColor()),
                  ),
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
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      height: 25,
                      width: double.infinity,
                      child: Text(
                        "${(listAllDocument[index].data() as Map<String, dynamic>)["username"]}",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.network(
                                      '${(listAllDocument[index].data() as Map<String, dynamic>)["image"]}')
                                  .image)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${(listAllDocument[index].data() as Map<String, dynamic>)["judul"]}",
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins'),
                            maxLines: 1,
                          ),
                          Text(
                            "${(listAllDocument[index].data() as Map<String, dynamic>)["deskripsi"]}",
                            style: TextStyle(
                                fontSize: 16.0, fontFamily: 'Poppins'),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "${(listAllDocument[index].data() as Map<String, dynamic>)["lokasi"]}",
                            style: TextStyle(
                                fontSize: 14.0, fontFamily: 'Poppins'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(""),
                              Text(
                                  "${(listAllDocument[index].data() as Map<String, dynamic>)["tanggal"]}",
                                  style: TextStyle(
                                      fontSize: 13.0, fontFamily: 'Poppins'),
                                  maxLines: 1),
                            ],
                          ),
                        ],
                      ),
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
