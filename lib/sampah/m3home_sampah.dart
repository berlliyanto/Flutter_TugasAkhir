// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant.dart';

class m3home extends StatelessWidget {
  static const nameRoute = '/m3home';
  double sizedheight = 20;
  double blurshadow = 10;

  m3home(String e, {super.key});
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
        //APPBAR------------------------------------------------------------------------------------
        appBar: AppBar(
          title: Text(
            "Mesin 3",
            style: TextStyle(fontSize: blockVertical * 2.5),
          ),
          backgroundColor: Color.fromARGB(255, 3, 167, 66),
          centerTitle: true,
          toolbarHeight: blockVertical * 8,
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
                  Navigator.pushNamed(context, mydashboard,
                      arguments: 'dari mesin 3');
                  // ignore: deprecated_member_use
                },
                icon: Icon(FontAwesomeIcons.house))
          ],
        ),
        //DRAWER------------------------------------------------------------------------------------
        drawer: Drawer(
          width: blockHorizontal * 80,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              //HEADER DRAWER--------------------------------------------------------------------------------------------------------
              Container(
                width: double.infinity,
                height: blockVertical * 25,
                padding: EdgeInsets.only(top: blockVertical * 5.5),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 3, 167, 66),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(-1, 2),
                        blurRadius: 2,
                      )
                    ],
                    image: DecorationImage(
                        image: AssetImage("images/asset1.png"),
                        fit: BoxFit.cover)),
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(bottom: blockVertical * 1),
                    height: blockVertical * 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.5),
                      radius: blockVertical * 4,
                      child: Icon(
                        Icons.person,
                        size: blockVertical * 6,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                              color: Colors.black,
                              offset: Offset(2, 2),
                              blurRadius: 10)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: blockVertical * 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome Nama...",
                        style: GoogleFonts.getFont('Roboto',
                            color: Colors.white, fontSize: blockVertical * 1.6),
                      ),
                      Icon(
                        Icons.emoji_emotions,
                        color: Colors.white,
                        size: blockVertical * 2.5,
                      ),
                    ],
                  ),
                  Text(
                    "Admin/User",
                    style: TextStyle(
                        color: Colors.white, fontSize: blockVertical * 1.3),
                  ),
                ]),
              ),
              // LIST DRAWER--------------------------------------------------------------------------------------------------------
              //Dashboard
              ListDrawer3((context), "Dashboard", mydashboard, "from drawer 3",
                  FontAwesomeIcons.house),

              //Mesin 1
              ListDrawer3((context), "Mesin 1", mym1home, "from drawer 3",
                  FontAwesomeIcons.display),

              //Mesin 2
              ListDrawer3((context), "Mesin 2", mym2home, "from drawer 3",
                  FontAwesomeIcons.display),

              //Mesin 3
              ListDrawer3((context), "Mesin 3", mym3home, "from drawer 3",
                  FontAwesomeIcons.display),

              //Mesin 4
              ListDrawer3((context), "Mesin 4", mym4home, "from drawer 3",
                  FontAwesomeIcons.display),

              // Kelola Akun
              ListDrawer3((context), "Kelola Akun", myakun, "from drawer 3",
                  FontAwesomeIcons.userGroup),

              // Preventive
              ListDrawer3((context), "Preventive Maintenance", mypreventive,
                  "from drawer 3", FontAwesomeIcons.chartArea),

              // Logout
              ListTile(
                contentPadding: EdgeInsets.only(
                    left: blockHorizontal * 15, bottom: blockVertical * 0.01),
                leading: Icon(FontAwesomeIcons.arrowRightFromBracket,
                    color: Colors.black, size: blockVertical * 3),
                title: Text(
                  "Log Out",
                  style: TextStyle(fontSize: blockVertical * 2.5),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Apakah Anda Yakin akan Keluar?"),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("TIDAK"),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, mylogin,
                                      arguments: 'from drawer');
                                },
                                child: Text("YA"))
                          ],
                        );
                      });
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                title: Text(
                  "Close",
                  style: TextStyle(fontSize: blockVertical * 2.5),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
        //BODY------------------------------------------------------------------------------------
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 4, 197, 97),
                      Color.fromARGB(255, 19, 220, 227),
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: blockHorizontal * 2, vertical: blockVertical * 2),
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
                                Color.fromARGB(255, 19, 220, 227),
                                Color.fromARGB(255, 4, 197, 97),
                              ])),
                      child: Text(
                        "Mesin 3 - Not Connected",
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
            //LIST MENU--------------------------------------------------------------------------------------------------------
            ListView(
              padding: EdgeInsets.fromLTRB(
                  10, blockVertical * 10, 10, blockVertical * 0.1),
              children: [
                Listmenu3((context), "Input Parameter", mym3param,
                    "from mesin 3", Icons.add_box),
                SizedBox(height: sizedheight),
                Listmenu3((context), "Cost Price", mym3cost, "from mesin 3",
                    Icons.price_change),
                SizedBox(height: sizedheight),
                Listmenu3((context), "OEE", mym3oee, "from mesin 3",
                    FontAwesomeIcons.chartPie),
                SizedBox(height: sizedheight),
                Listmenu3((context), "Production", mym3monitoring,
                    "from mesin 3", FontAwesomeIcons.cartFlatbed),
                SizedBox(height: sizedheight),
                Listmenu3((context), "Pressure", mym3pressure, "from mesin 3",
                    FontAwesomeIcons.gauge),
                SizedBox(height: sizedheight),
                Listmenu3((context), "Energy Usage", mym3energy, "from mesin 3",
                    FontAwesomeIcons.bolt),
                SizedBox(height: sizedheight),
                Listmenu3((context), "Troubleshoot", mym3alarm, "from mesin 3",
                    FontAwesomeIcons.solidBell),
                SizedBox(height: sizedheight),
                Listmenu3((context), "Report", mym3pdf, "from mesin 3",
                    Icons.picture_as_pdf),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // FUNCTION LIST MENU HALAMAN MESIN 3--------------------------------------------------------------------------------------------------------
  Widget Listmenu3(BuildContext context, String title, String navigate,
      String arg, IconData icon) {
    return Container(
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 2, 61, 77),
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

  // FUNCTION LIST MENU DRAWER MESIN 3--------------------------------------------------------------------------------------------------------
  Widget ListDrawer3(BuildContext contextdrawer, String titledrawer,
      String navdrawer, String argdrawer, IconData icondrawer) {
    // UNTUK LEBAR TAMPILAN
    final MediaQuerywidth = MediaQuery.of(contextdrawer).size.width;
    double blockHorizontal = MediaQuerywidth / 100;

    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(contextdrawer).size.height;
    double blockVertical = MediaQueryheight / 100;

    return ListTile(
      contentPadding: EdgeInsets.only(
          left: blockHorizontal * 15, bottom: blockVertical * 0.01),
      leading: Icon(
        icondrawer,
        color: Colors.black,
        size: blockVertical * 3,
      ),
      title: Text(
        titledrawer,
        style: TextStyle(fontSize: blockVertical * 2.5),
      ),
      onTap: () {
        Navigator.pushNamed(contextdrawer, navdrawer, arguments: argdrawer);
      },
    );
  }
}
