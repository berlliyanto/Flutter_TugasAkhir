// ignore_for_file: file_names

import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:lottie/lottie.dart';

class getStarted extends StatefulWidget {
  const getStarted(String au, {super.key});

  @override
  State<getStarted> createState() => _getStartedState();
}

class _getStartedState extends State<getStarted> {
  @override
  Widget build(BuildContext context) {
    // UNTUK LEBAR TAMPILAN
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;

    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;

    // Mengetahui Orientasi Device
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            top: false,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipPath(
                    clipper: myClipper(),
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      height: blockVertical * 20,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 5, 8, 185),
                              Color.fromARGB(255, 2, 71, 83),
                            ]),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(right: blockHorizontal*5),
                        height: blockVertical*8,
                        width: blockVertical*8,
                        decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("images/asset7.png"))
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Lottie.asset("lottie/monitor.json"),
                    ),
                  ),
                  ClipPath(
                    clipper: myClipper2(),
                    child: Container(
                      padding: EdgeInsets.only(top: blockVertical * 1, left: blockHorizontal*5, right: blockHorizontal*5),
                      width: double.infinity,
                      height: blockVertical * 35,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color.fromARGB(255, 9, 28, 243),
                              Color.fromARGB(255, 1, 75, 75),
                            ]),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.grey,
                            child: Text("Welcome to", style: TextStyle(color: Colors.white, fontSize: blockVertical*3),)),
                          Shimmer.fromColors(
                            baseColor: Colors.white,
                            highlightColor: Colors.grey,
                            child: Text("Production Monitoring System", style: TextStyle(color: Colors.white, fontSize: blockVertical*6, fontWeight: FontWeight.bold),)),
                          SizedBox(height: blockVertical*1,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                splashColor: Colors.white.withOpacity(0.5),
                                onTap: (){
                                  Navigator.pushReplacementNamed(context, mylogin, arguments: "from getSTarted");
                                },
                                child: Container(
                                  padding: EdgeInsets.only(left: 15, right: 5),
                                  height: blockVertical*5,
                                  width: blockHorizontal*40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color.fromARGB(255, 0, 102, 255),
                                    boxShadow: [BoxShadow(
                                      offset: Offset(8 , 8),
                                      color: Colors.black.withOpacity(0.6),
                                      blurRadius: 10,
                                    )]
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Shimmer.fromColors(
                                        baseColor: Colors.white,
                                        highlightColor: Colors.grey,
                                        child: Text("Login", style: TextStyle(color: Colors.white, fontSize: blockVertical*3, fontWeight: FontWeight.bold),)),
                                      Shimmer.fromColors(
                                        baseColor: Colors.white,
                                        highlightColor: Colors.grey,
                                        child: Icon(Icons.keyboard_arrow_right_outlined, color: Colors.white,size: blockVertical*4,))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class myClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
        size.width / 4, size.height / 2, size.width / 2, size.height - 40);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // ignore: todo
    //TODO: implement shouldReclip
    return true;
  }
}

class myClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // ignore: todo
    //TODO: implement shouldReclip
    return true;
  }
}

class myClipper3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // ignore: todo
    //TODO: implement shouldReclip
    return true;
  }
}

class myClipper4 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 70);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 70);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // ignore: todo
    //TODO: implement shouldReclip
    return true;
  }
}
