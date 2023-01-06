import 'package:app_pengaduan_masyarakat_bna/admin_panel/view/detail_item_admin.dart';
import 'package:flutter/material.dart';

class list_aduan_admin extends StatelessWidget {
  var listAllDocument;
  list_aduan_admin({this.listAllDocument, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listAllDocument.length,
      itemBuilder: (BuildContext context, int index) => Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                var detail =
                    listAllDocument[index].data() as Map<String, dynamic>;

                Route route = MaterialPageRoute(
                    builder: (context) => detail_item_admin(
                          detail: detail,
                        ));
                Navigator.push(context, route);
              },
              child: Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                height: 350,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: Image.network(
                                      '${(listAllDocument[index].data() as Map<String, dynamic>)["image"]}')
                                  .image)),
                    ),
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
                      style: TextStyle(fontSize: 16.0, fontFamily: 'Poppins'),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "${(listAllDocument[index].data() as Map<String, dynamic>)["lokasi"]}",
                      style: TextStyle(fontSize: 14.0, fontFamily: 'Poppins'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "${(listAllDocument[index].data() as Map<String, dynamic>)["username"]}"),
                        Text(
                            "${(listAllDocument[index].data() as Map<String, dynamic>)["tanggal"]}",
                            style: TextStyle(
                                fontSize: 13.0, fontFamily: 'Poppins'),
                            maxLines: 1),
                      ],
                    ),
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
