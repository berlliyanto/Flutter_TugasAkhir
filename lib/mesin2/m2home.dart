// ignore_for_file: prefer_const_literals_to_create_immutables, must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constant.dart';

class m2home extends StatelessWidget {
  static const nameRoute = '/m2home';
  double sizedheight = 20;
  double blurshadow = 10;

  m2home(String d, {super.key});
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
            "Mesin 2",
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 117, 6, 207).withOpacity(0.5),
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
                      arguments: 'dari mesin 1');
                  // ignore: deprecated_member_use
                },
                icon: Icon(FontAwesomeIcons.house))
          ],
        ),
        //DRAWER------------------------------------------------------------------------------------
        drawer: drawer(),
        //BODY----------------------------------------------------------------------------------------------------------------------------------
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 35, 1, 44),
            image: DecorationImage(image: AssetImage("images/asset2.png"), fit: BoxFit.cover)
          ),
          child: Container(
            padding: EdgeInsets.only(top: blockVertical*8),
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(end: Alignment.bottomCenter, begin: Alignment.topCenter, colors: [
                Color.fromARGB(255, 36, 36, 36).withOpacity(0.7), Color.fromARGB(255, 117, 117, 117).withOpacity(0.4)
              ])
            ),
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                  10, blockVertical * 1, 10, blockVertical * 0.1),
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
                                    Color.fromARGB(255, 145, 58, 203),
                                    Color.fromARGB(255, 76, 13, 177),
                                  ])),
                          child: Text(
                            "Mesin 1 - Not Connected",
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
                Listmenu2((context), "Input Parameter", mym2param, "from mesin 2",
                    Icons.add_box),
                SizedBox(height: sizedheight),
                Listmenu2((context), "Cost Price", mym2cost, "from mesin 2",
                    Icons.price_change),
                SizedBox(height: sizedheight),
                Listmenu2((context), "OEE", mym2oee, "from mesin 2",
                    FontAwesomeIcons.chartPie),
                SizedBox(height: sizedheight),
                Listmenu2((context), "Monitoring", mym2monitoring, "from mesin 2",
                    FontAwesomeIcons.computer),
                SizedBox(height: sizedheight),
                Listmenu2((context), "Stock Bahan", mym2stock, "from mesin 2",
                    FontAwesomeIcons.boxOpen),
                SizedBox(height: sizedheight),
                Listmenu2((context), "Alarm Event", mym2alarm, "from mesin 2",
                    FontAwesomeIcons.solidBell),
                SizedBox(height: sizedheight),
                Listmenu2((context), "Report", mym2pdf, "from mesin 2",
                    Icons.picture_as_pdf),
                SizedBox(height: sizedheight),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // FUNCTION LIST MENU HALAMAN MESIN 2--------------------------------------------------------------------------------------------------------
  Widget Listmenu2(BuildContext context, String title, String navigate,
      String arg, IconData icon) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 37, 2, 77),
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
