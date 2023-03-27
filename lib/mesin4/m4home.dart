// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constant.dart';

class m4home extends StatelessWidget {
  static const nameRoute = '/m4home';
  double sizedheight = 20;
  double blurshadow = 10;

  m4home(String f, {super.key});
  @override
  Widget build(BuildContext context) {
    // UNTUK LEBAR TAMPILAN
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;

    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    final myappbar = AppBar(
      title: Text("Media Query"),
    );
    final bodyheight = MediaQueryheight -
        myappbar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    // Mengetahui Orientasi Device
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        //APPBAR------------------------------------------------------------------------------------
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          toolbarHeight: blockVertical * 6,
          shadowColor: Colors.transparent,
          title: Text(
            "Mesin 4",
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 54, 43, 43).withOpacity(0.5),
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                FontAwesomeIcons.bars,
                size: blockVertical * 3,
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, mydashboard,
                      arguments: 'dari mesin 2');
                  // ignore: deprecated_member_use
                },
                icon: Icon(FontAwesomeIcons.house))
          ],
        ),
        //DRAWER-----------------------------------------------------------------------------------
        drawer: drawer(),
        //BODY------------------------------------------------------------------------------------
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(image: AssetImage("images/asset23.jpg"), fit: BoxFit.cover)
          ),
          child: Container(
            padding: EdgeInsets.only(top: blockVertical*8),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(end: Alignment.bottomCenter, begin: Alignment.topCenter, colors: [
                Color.fromARGB(255, 26, 26, 26).withOpacity(0.9), Color.fromARGB(255, 117, 117, 117).withOpacity(0.85)
              ])
            ),
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                  blockHorizontal*2, blockVertical * 3, blockHorizontal*2, blockVertical * 0.1),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: blockHorizontal * 2,
                      vertical: blockVertical * 2),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: blockHorizontal * 3),
                          alignment: Alignment.centerLeft,
                          height: blockVertical * 6,
                          width: MediaQuerywidth,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(blockVertical * 1),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    offset: Offset(5, 10),
                                    blurRadius: 10)
                              ],
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color.fromARGB(255, 129, 118, 192),
                                    Color.fromARGB(255, 40, 41, 56),
                                  ])),
                          child: Text(
                            "Mesin 4 - Not Connected",
                            style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: blockVertical * 3,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Listmenu4((context), "Input Parameter", mym4param, "from mesin 4",
                    Icons.add_box),
                SizedBox(height: sizedheight),
                Listmenu4((context), "Cost Price", mym4cost, "from mesin 4",
                    Icons.price_change),
                SizedBox(height: sizedheight),
                Listmenu4((context), "OEE", mym4oee, "from mesin 4",
                    FontAwesomeIcons.chartPie),
                SizedBox(height: sizedheight),
                Listmenu4((context), "Monitoring", mym4monitoring, "from mesin 4",
                    FontAwesomeIcons.cartFlatbed),
                SizedBox(height: sizedheight),
                Listmenu4((context), "Stock", mym4stock, "from mesin 4",
                    FontAwesomeIcons.boxOpen),
                SizedBox(height: sizedheight),
                Listmenu4((context), "Troubleshoot", mym4alarm, "from mesin 4",
                    FontAwesomeIcons.solidBell),
                SizedBox(height: sizedheight),
                Listmenu4((context), "Report", mym4pdf, "from mesin 4",
                    Icons.picture_as_pdf),
                SizedBox(height: sizedheight),
              ],
            ),
          ),
        ),
      ),
    );
  }

// FUNCTION LIST MENU HALAMAN MESIN 4--------------------------------------------------------------------------------------------------------
  Widget Listmenu4(BuildContext context, String title, String navigate,
      String arg, IconData icon) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 53, 57, 73),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(10, 10),
              blurRadius: blurshadow,
            )
          ]),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        trailing: Icon(
          Icons.arrow_right,
          color: Colors.white,
        ),
        onTap: () {
          Navigator.pushNamed(context, navigate, arguments: arg);
        },
      ),
    );
  }
}
