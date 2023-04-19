import 'package:flutter/material.dart';
import 'package:flutter_application_1/back_button_pop.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class historiTB extends StatefulWidget {
  const historiTB(String av, {super.key});

  @override
  State<historiTB> createState() => _historiTBState();
}

class _historiTBState extends State<historiTB> {
  @override
  Widget build(BuildContext context) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;

    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return MaterialApp(
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          toolbarHeight: blockVertical * 6,
          shadowColor: Colors.transparent,
          title: Text(
            "History Troubleshoot",
            style: TextStyle(fontSize: blockVertical * 2.5),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 2, 66, 87).withOpacity(0.5),
          leading: backbutton(context),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, mydashboard,
                      arguments: 'dari mesin 1');
                  // ignore: deprecated_member_use
                },
                icon: Icon(FontAwesomeIcons.house)),
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 32, 146, 184),
                  Color.fromARGB(255, 4, 44, 61),
                ]),
          ),
          child: Container(
            margin: EdgeInsets.only(top: blockVertical*12),
            height: blockVertical*80,
            width: MediaQuerywidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(blockVertical*3),topRight: Radius.circular(blockVertical*3)),
              
            ),
          )
        ),
      ),
    );
  }
}