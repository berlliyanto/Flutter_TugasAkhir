// ignore_for_file: unused_local_variable


import 'package:flutter/material.dart';
import 'package:flutter_application_1/back_button_pop.dart';


class m1pdf extends StatefulWidget {
  static const nameRoute = '/m1pdf';
  const m1pdf(String n, {super.key});

  @override
  State<m1pdf> createState() => _m1pdfState();
}

class _m1pdfState extends State<m1pdf> {


  @override
  Widget build(BuildContext context) {
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Mesin 1 Report",
            style: TextStyle(fontSize: blockVertical * 2.5),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 6, 160, 207),
          toolbarHeight: blockVertical * 8,
          leading: backbutton(context),
        ),
        body: Container(
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
          child: ElevatedButton(
            onPressed: () {
            },
            child: Text("data"),
          ),
        ),
      ),
    );
  }


}
