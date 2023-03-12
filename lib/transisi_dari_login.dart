// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:percent_indicator/percent_indicator.dart';

class fromLogin extends StatefulWidget {
  static const nameRoute = '/fromLogin';

  const fromLogin(String at, {super.key});
  @override
  State<fromLogin> createState() => _fromLoginState();
}

class _fromLoginState extends State<fromLogin> {
  @override
  void initState() {
    super.initState();
    fromLogin();
  }

  //TIMER GANTI SCREEN----------------------------------------------------------------------------------------------------------------
  fromLogin() async {
    var duration = const Duration(seconds: 3);
    return Timer(
      duration,
      () {
        Navigator.pushReplacementNamed(context, mydashboard, arguments: 'fromLogin');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
     final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;

    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return Scaffold(
      body: Container(
        height: MediaQueryheight,
        width: MediaQuerywidth,
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Login Success!!!", style: TextStyle(color: Colors.white, fontSize: blockVertical*3, fontWeight: FontWeight.bold),),
              SizedBox(height: blockVertical*0.2,),
              Text("Please Wait...",style: TextStyle(color: Colors.white, fontSize: blockVertical*2)),
              SizedBox(height: blockVertical*1,),
              LinearPercentIndicator(
                width: MediaQuerywidth,
                lineHeight: blockVertical*2,
                barRadius: Radius.circular(blockVertical*2),
                percent: 1,
                progressColor: Color.fromARGB(255, 0, 134, 243),
                backgroundColor: Colors.blue.withOpacity(0.3),
                animation: true,
                animationDuration: 2500,
              )
            ],
          ),
        ),
      ),
    );  
  }
}
