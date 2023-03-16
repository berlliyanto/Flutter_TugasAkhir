// ignore_for_file: prefer_const_literals_to_create_immutables


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/Services/param_service.dart';

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  int state0 = 0;
  //SAVE DATA LOGIN TO LOCAL MEMORY--------------------------------------------------------------------------------------------
  String? name,otoritas;
  Future<void> getValidUser() async{
    final SharedPreferences shared = await SharedPreferences.getInstance();
    var getName = shared.getString("name");
    var getOtoritas = shared.getString("otoritas");
    setState(() {
      name = getName;
      otoritas = getOtoritas;
    });
  }
  @override
  void initState() {
    getValidUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;

    return Drawer(
      width: blockHorizontal * 80,
      child: (otoritas=="Admin")
      //ADMIN------------------------------------------------------------------------------------------------------------
      ?
      ListView(
        padding: EdgeInsets.zero,
        children: [
          //HEADER DRAWER----------------------------------------------------------------------------------------------------------------
          Container(
            width: double.infinity,
            height: blockVertical * 25,
            padding: EdgeInsets.only(top: blockVertical * 5.5),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 3, 131, 167),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(-1, 2),
                    blurRadius: 2,
                  )
                ],
                image: DecorationImage(
                    image: AssetImage("images/asset3.png"), fit: BoxFit.cover)),
            child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(bottom: blockVertical * 1),
                    height: blockVertical * 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage:AssetImage('images/asset21.jpg'),
                      radius: blockVertical * 4,
                    ),
                  ),
                  SizedBox(
                    height: blockVertical * 1,
                  ),
                  Text(
                    "$name",
                    style: GoogleFonts.getFont('Roboto',
                        color: Colors.white, fontSize: blockVertical * 1.8, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "$otoritas",
                    style: TextStyle(
                        color: Colors.white, fontSize: blockVertical * 1.5, fontWeight: FontWeight.bold),
                  ),
                ])

          ),
          // LIST DRAWER----------------------------------------------------------------------------------------------------------------
          //Dashboard
          ListTile(
            contentPadding: EdgeInsets.only(
                left: blockHorizontal * 15, bottom: blockVertical * 0.01),
            leading: Icon(
              FontAwesomeIcons.house,
              color: Colors.black,
              size: blockVertical * 3,
            ),
            title: Text(
              "Dashboard ",
              style: TextStyle(fontSize: blockVertical * 2.5),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, mydashboard,
                  arguments: 'from drawer');
            },
          ),
          //Mesin 1
          ListTile(
            contentPadding: EdgeInsets.only(
                left: blockHorizontal * 15, bottom: blockVertical * 0.01),
            leading: Icon(
              FontAwesomeIcons.display,
              color: Colors.black,
              size: blockVertical * 3,
            ),
            title: Text(
              "Mesin 1",
              style: TextStyle(fontSize: blockVertical * 2.5),
            ),
            onTap: () {
              Navigator.pushNamed(context, mym1home, arguments: 'from drawer');
            },
          ),
          //Mesin 2
          ListTile(
            contentPadding: EdgeInsets.only(
                left: blockHorizontal * 15, bottom: blockVertical * 0.01),
            leading: Icon(FontAwesomeIcons.display,
                color: Colors.black, size: blockVertical * 3),
            title: Text(
              "Mesin 2",
              style: TextStyle(fontSize: blockVertical * 2.5),
            ),
            onTap: () {
              Navigator.pushNamed(context, mym2home, arguments: 'from drawer');
            },
          ),
          //Mesin 3
          ListTile(
            contentPadding: EdgeInsets.only(
                left: blockHorizontal * 15, bottom: blockVertical * 0.01),
            leading: Icon(FontAwesomeIcons.display,
                color: Colors.black, size: blockVertical * 3),
            title: Text(
              "Mesin 3",
              style: TextStyle(fontSize: blockVertical * 2.5),
            ),
            onTap: () {
              Navigator.pushNamed(context, mym3home, arguments: 'from drawer');
            },
          ),
          //Mesin 4
          ListTile(
            contentPadding: EdgeInsets.only(
                left: blockHorizontal * 15, bottom: blockVertical * 0.01),
            leading: Icon(FontAwesomeIcons.display,
                color: Colors.black, size: blockVertical * 3),
            title: Text(
              "Mesin 4",
              style: TextStyle(fontSize: blockVertical * 2.5),
            ),
            onTap: () {
              Navigator.pushNamed(context, mym4home, arguments: 'from drawer');
            },
          ),
          // Preventive
          ListTile(
            contentPadding: EdgeInsets.only(
                left: blockHorizontal * 15, bottom: blockVertical * 0.01),
            leading: Icon(FontAwesomeIcons.chartArea,
                color: Colors.black, size: blockVertical * 3),
            title: Text(
              "Preventive Maintenance",
              style: TextStyle(fontSize: blockVertical * 2.5),
            ),
            onTap: () {
              Navigator.pushNamed(context, mypreventive,
                  arguments: 'from drawer');
            },
          ),
          // Kelola Akun
          ListTile(
            contentPadding: EdgeInsets.only(
                left: blockHorizontal * 15, bottom: blockVertical * 0.01),
            leading: Icon(FontAwesomeIcons.userGroup,
                color: Colors.black, size: blockVertical * 3),
            title: Text(
              "Kelola Akun",
              style: TextStyle(fontSize: blockVertical * 2.5),
            ),
            onTap: () {
              Navigator.pushNamed(context, myakun, arguments: 'from drawer');
            },
          ),

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
              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.question,
                  animType: AnimType.leftSlide,
                  title: "Log Out",
                  desc: "Apakah Anda Yakin Mau Keluar?",
                  useRootNavigator: true,
                  btnCancelIcon: FontAwesomeIcons.xmark,
                  btnCancelOnPress: () {},
                  btnOkIcon: FontAwesomeIcons.arrowRightFromBracket,
                  btnOkOnPress: () async {
                    final SharedPreferences shared = await SharedPreferences.getInstance();
                    shared.remove("name");
                    shared.remove("otoritas");
                    shared.remove("A");
                    shared.remove("B");
                    shared.remove("C");
                    shared.remove("stateParamM1");
                    shared.remove("tipeParamM1");          
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamedAndRemoveUntil(
                        context, mylogin, (route) => false,
                        arguments: "from drawer");
                  }).show();
                  resetParam.putParam(state0);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(
                left: blockHorizontal * 5, bottom: blockVertical * 0.01),
            leading:
                Icon(Icons.close, color: Colors.black, size: blockVertical * 3),
            title: Text(
              "Close",
              style: TextStyle(fontSize: blockVertical * 2.5),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      )
      //SELAIN ADMIN-----------------------------------------------------------------------------------------------------
      :
      ListView(
        padding: EdgeInsets.zero,
        children: [
          //HEADER DRAWER----------------------------------------------------------------------------------------------------------------
          Container(
            width: double.infinity,
            height: blockVertical * 25,
            padding: EdgeInsets.only(top: blockVertical * 5.5),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 3, 131, 167),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(-1, 2),
                    blurRadius: 2,
                  )
                ],
                image: DecorationImage(
                    image: AssetImage("images/asset3.png"), fit: BoxFit.cover)),
            child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(bottom: blockVertical * 1),
                    height: blockVertical * 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundImage:AssetImage('images/asset4.png'),
                      radius: blockVertical * 4,
                    ),
                  ),
                  SizedBox(
                    height: blockVertical * 1,
                  ),
                  Text(
                    "$name",
                    style: GoogleFonts.getFont('Roboto',
                        color: Colors.white, fontSize: blockVertical * 1.8, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    "$otoritas",
                    style: TextStyle(
                        color: Colors.white, fontSize: blockVertical * 1.5, fontWeight: FontWeight.bold),
                  ),
                ])

          ),
          // LIST DRAWER----------------------------------------------------------------------------------------------------------------
          //Dashboard
          ListTile(
            contentPadding: EdgeInsets.only(
                left: blockHorizontal * 15, bottom: blockVertical * 0.01),
            leading: Icon(
              FontAwesomeIcons.house,
              color: Colors.black,
              size: blockVertical * 3,
            ),
            title: Text(
              "Dashboard ",
              style: TextStyle(fontSize: blockVertical * 2.5),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, mydashboard,
                  arguments: 'from drawer');
            },
          ),
          //Mesin 1
          ListTile(
            contentPadding: EdgeInsets.only(
                left: blockHorizontal * 15, bottom: blockVertical * 0.01),
            leading: Icon(
              FontAwesomeIcons.display,
              color: Colors.black,
              size: blockVertical * 3,
            ),
            title: Text(
              "Mesin 1",
              style: TextStyle(fontSize: blockVertical * 2.5),
            ),
            onTap: () {
              Navigator.pushNamed(context, mym1home, arguments: 'from drawer');
            },
          ),
          //Mesin 2
          ListTile(
            contentPadding: EdgeInsets.only(
                left: blockHorizontal * 15, bottom: blockVertical * 0.01),
            leading: Icon(FontAwesomeIcons.display,
                color: Colors.black, size: blockVertical * 3),
            title: Text(
              "Mesin 2",
              style: TextStyle(fontSize: blockVertical * 2.5),
            ),
            onTap: () {
              Navigator.pushNamed(context, mym2home, arguments: 'from drawer');
            },
          ),
          //Mesin 3
          ListTile(
            contentPadding: EdgeInsets.only(
                left: blockHorizontal * 15, bottom: blockVertical * 0.01),
            leading: Icon(FontAwesomeIcons.display,
                color: Colors.black, size: blockVertical * 3),
            title: Text(
              "Mesin 3",
              style: TextStyle(fontSize: blockVertical * 2.5),
            ),
            onTap: () {
              Navigator.pushNamed(context, mym3home, arguments: 'from drawer');
            },
          ),
          //Mesin 4
          ListTile(
            contentPadding: EdgeInsets.only(
                left: blockHorizontal * 15, bottom: blockVertical * 0.01),
            leading: Icon(FontAwesomeIcons.display,
                color: Colors.black, size: blockVertical * 3),
            title: Text(
              "Mesin 4",
              style: TextStyle(fontSize: blockVertical * 2.5),
            ),
            onTap: () {
              Navigator.pushNamed(context, mym4home, arguments: 'from drawer');
            },
          ),
          // Preventive
          ListTile(
            contentPadding: EdgeInsets.only(
                left: blockHorizontal * 15, bottom: blockVertical * 0.01),
            leading: Icon(FontAwesomeIcons.chartArea,
                color: Colors.black, size: blockVertical * 3),
            title: Text(
              "Preventive Maintenance",
              style: TextStyle(fontSize: blockVertical * 2.5),
            ),
            onTap: () {
              Navigator.pushNamed(context, mypreventive,
                  arguments: 'from drawer');
            },
          ),
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
              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.question,
                  animType: AnimType.leftSlide,
                  title: "Log Out",
                  desc: "Apakah Anda Yakin Mau Keluar?",
                  useRootNavigator: true,
                  btnCancelIcon: FontAwesomeIcons.xmark,
                  btnCancelOnPress: () {},
                  btnOkIcon: FontAwesomeIcons.arrowRightFromBracket,
                  btnOkOnPress: () async {
                    final SharedPreferences shared = await SharedPreferences.getInstance();
                    shared.remove("name");
                    shared.remove("otoritas");
                    shared.remove("A");
                    shared.remove("B");
                    shared.remove("C");
                    shared.remove("stateParamM1");
                    shared.remove("tipeParamM1"); 
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamedAndRemoveUntil(
                        context, mylogin, (route) => false,
                        arguments: "from drawer");
                  }).show();
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.only(
                left: blockHorizontal * 5, bottom: blockVertical * 0.01),
            leading:
                Icon(Icons.close, color: Colors.black, size: blockVertical * 3),
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
    );
  }
}
