// ignore_for_file: must_be_immutable, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constant.dart';

class m1home extends StatefulWidget {
  static const nameRoute = '/m1home';

  const m1home(String c, {super.key});

  @override
  State<m1home> createState() => _m1homeState();
}

class _m1homeState extends State<m1home> {
  int id = 0;
  double sizedheight = 20;
  double blurshadow = 10;

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
      home: Scaffold(
        //APPBAR------------------------------------------------------------------------------------
        appBar: AppBar(
          title: Text(
            "Mesin 1",
            style: TextStyle(fontSize: blockVertical * 2.5),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 6, 160, 207),
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
                      arguments: 'dari mesin 1');
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
                    color: Color.fromARGB(255, 6, 160, 207),
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
              ListDrawer1((context), "Dashboard", mydashboard, "from drawer 4",
                  FontAwesomeIcons.house),

              //Mesin 1
              ListDrawer1((context), "Mesin 1", mym1home, "from drawer 4",
                  FontAwesomeIcons.display),

              //Mesin 2
              ListDrawer1((context), "Mesin 2", mym2home, "from drawer 4",
                  FontAwesomeIcons.display),

              //Mesin 3
              ListDrawer1((context), "Mesin 3", mym3home, "from drawer 4",
                  FontAwesomeIcons.display),

              //Mesin 4
              ListDrawer1((context), "Mesin 4", mym4home, "from drawer 4",
                  FontAwesomeIcons.display),

              // Kelola Akun
              ListDrawer1((context), "Kelola Akun", myakun, "from drawer 4",
                  FontAwesomeIcons.userGroup),

              // Preventive
              ListDrawer1((context), "Preventive Maintenance", mypreventive,
                  "from drawer 4", FontAwesomeIcons.chartArea),

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
        //BODY---------------------------------------------------------------------------------------------------------------------------------
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
                      Color.fromARGB(255, 29, 206, 215),
                      Color.fromARGB(255, 19, 78, 227),
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
                                Color(0xFF3ac3cb),
                                Color.fromARGB(255, 13, 158, 177),
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
            ListView(
              padding: EdgeInsets.fromLTRB(
                  10, blockVertical * 10, 10, blockVertical * 0.1),
              children: [
                Listmenu1((context), "Input Parameter", mym1param,
                    "from mesin 1", Icons.add_box),
                SizedBox(height: sizedheight),
                Listmenu1((context), "Cost Price", mym1cost, "from mesin 1",
                    Icons.price_change),
                SizedBox(height: sizedheight),
                Listmenu1((context), "OEE", mym1oee, "from mesin 1",
                    FontAwesomeIcons.chartPie),
                SizedBox(height: sizedheight),
                Listmenu1((context), "Production", mym1monitoring,
                    "from mesin 1", FontAwesomeIcons.cartFlatbed),
                SizedBox(height: sizedheight),
                Listmenu1((context), "Pressure", mym1pressure, "from mesin 1",
                    FontAwesomeIcons.gauge),
                SizedBox(height: sizedheight),
                Listmenu1((context), "Energy Usage", mym1energy, "from mesin 1",
                    FontAwesomeIcons.bolt),
                SizedBox(height: sizedheight),
                Listmenu1((context), "Troubleshoot", mym1alarm, "from mesin 1",
                    FontAwesomeIcons.solidBell),
                SizedBox(height: sizedheight),
                Listmenu1((context), "Report", mym1pdf, "from mesin 1",
                    Icons.picture_as_pdf),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // MODEL LIST MENU HALAMAN MESIN 1--------------------------------------------------------------------------------------------------------
  Widget Listmenu1(BuildContext context, String title, String navigate,
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

  // MODEL LIST MENU DRAWER MESIN 1--------------------------------------------------------------------------------------------------------
  Widget ListDrawer1(BuildContext contextdrawer, String titledrawer,
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
        setState(() {
          id = 1;
          print(id);
        });
      },
    );
  }
}
