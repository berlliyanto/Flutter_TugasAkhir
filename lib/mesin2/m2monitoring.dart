// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/back_button_pop.dart';

class m2monitoring extends StatelessWidget {
  static const nameRoute = '/m2monitoring';
  const m2monitoring(String y, {super.key});

  @override
  Widget build(BuildContext context) {

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
      home: Scaffold(
        appBar: AppBar(
          title: Text("Mesin 2 Monitoring",style: TextStyle(fontSize: blockVertical * 2.5),),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 3, 131, 167),
          toolbarHeight: blockVertical * 8,
          leading: backbutton(context),
        ),
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
                      Color(0xFF3ac3cb),
                      Color(0xFFFFFFFF),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
