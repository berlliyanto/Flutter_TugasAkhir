// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer.dart';
import 'package:flutter_application_1/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class preventive extends StatefulWidget {
  static const nameRoute = '/preventive';

  const preventive(String h, {super.key});

  @override
  State<preventive> createState() => _preventiveState();
}

class _preventiveState extends State<preventive> {
  bool state = true;
  @override
  Widget build(BuildContext context) {
    // UNTUK LEBAR TAMPILAN
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;

    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      home: Scaffold(
        appBar: AppBar(),
        drawer: drawer(),
        body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: blockVertical*2),
              padding: EdgeInsets.all(blockVertical*0.5),
              height: blockVertical*5,
              width: blockHorizontal*50,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240),
                borderRadius: BorderRadius.circular(blockVertical*3),
                boxShadow: [BoxShadow(
                  offset: Offset(3, 3),
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 5
                )]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: blockVertical*4,
                    width: blockHorizontal*23.5,
                    decoration: BoxDecoration(
                      color: (state)?Color.fromARGB(255, 3, 89, 218):Color.fromARGB(255, 43, 60, 87),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20)
                      )
                    ),
                    child: IconButton(onPressed: (){
                      setState(() {
                        state = true;
                      });
                    },
                      icon:Icon(FontAwesomeIcons.listOl, color: Colors.black,size: blockVertical*3,)),
                  ),
                  Container(
                    height: blockVertical*4,
                    width: blockHorizontal*23.5,
                    decoration: BoxDecoration(
                      color: (state)?Color.fromARGB(255, 43, 60, 87):Color.fromARGB(255, 3, 89, 218),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                      )
                    ),
                    child: IconButton(onPressed: (){
                      setState(() {
                        state = false;
                      });
                    },
                      icon:Icon(FontAwesomeIcons.chartColumn, color: Colors.black,size: blockVertical*3,)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        setState(() {
          state = !state;
          print(state);
        });
      }),
      ),
    );
  }
}

