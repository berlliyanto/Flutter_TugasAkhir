import 'dart:ui';

import 'package:flutter/material.dart';

Widget buildCard(BuildContext context ,IconData icon, String title, String A, String B, String C,
      String routeName) {
    // UNTUK LEBAR TAMPILAN
    final MediaQuerywidth = MediaQuery.of(context).size.width;

    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return ClipRRect(
      borderRadius: BorderRadius.circular(blockVertical * 2),
      child: Container(
        width: MediaQuerywidth * 0.75,
        height: MediaQueryheight * 0.23,
        color: Colors.transparent,
        child: Stack(children: [
          //blurEffect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
            child: Container(),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(blockVertical * 2),
                border: Border.all(
                  color: Colors.white.withOpacity(0.13),
                ),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.white.withOpacity(0.5)
                    ])),
            child: InkWell(
              splashColor: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: blockVertical * 5,
                    color: Colors.white,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: blockVertical * 3,
                        color: Colors.white),
                  ),
                  SizedBox(height: blockVertical * 2.5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        A,
                        style: TextStyle(
                            color: Colors.white, fontSize: blockVertical * 2),
                      ),
                      Text(B,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: blockVertical * 2)),
                      Text(C,
                          style: TextStyle(
                              color: Colors.white, fontSize: blockVertical * 2))
                    ],
                  ),
                  SizedBox(
                    height: blockVertical * 0.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "20",
                        style: TextStyle(
                            fontSize: blockVertical * 2.5, color: Colors.white),
                      ),
                      Text("30",
                          style: TextStyle(
                              fontSize: blockVertical * 2.5,
                              color: Colors.white)),
                      Text("40",
                          style: TextStyle(
                              fontSize: blockVertical * 2.5,
                              color: Colors.white)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }