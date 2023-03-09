// ignore_for_file: unused_local_variable, prefer_adjacent_string_concatenation


import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class bodyProduction extends StatefulWidget {
  const bodyProduction({super.key});

  @override
  State<bodyProduction> createState() => _bodyProductionState();
}

class _bodyProductionState extends State<bodyProduction> {
  @override
  Widget build(BuildContext context) {
    // UNTUK LEBAR TAMPILAN
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;

    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          blockHorizontal * 1.8, blockVertical * 3, blockHorizontal * 1.8, 0),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(blockVertical * 3),
        child: Container(
          height: blockVertical * 46,
          width: blockHorizontal * 93,
          color: Colors.transparent,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
        margin: EdgeInsets.fromLTRB(blockHorizontal * 0.1, blockVertical * 0.01,
            blockHorizontal * 0.1, blockVertical * 0.01),
        width: blockHorizontal * 85,
        height: blockVertical * 87 / 2,
        color: Colors.transparent,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Mesin 1----------------------------------------------------------
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  height: constraints.maxHeight * 0.45,
                  width: constraints.maxWidth * 0.9,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 7, 197, 255),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,5),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, mym1monitoring, arguments: "from dash");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Mesin 1", style: TextStyle(
                                  color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold
                                  ),
                                ),
                                Icon(FontAwesomeIcons.angleRight,color: Colors.white, )
                              ],
                            ),
                          ),
                        ),   
                      Container(
                        height: 2,
                        width: constraints.maxWidth*0.9,
                        color: Colors.lightBlue,
                      ),
                      SizedBox(height: constraints.maxHeight*0.025,),
                      Row(
                        children: [
                          Text("Status Mesin : ", style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05),),
                          ClipOval(
                            child: Container(
                              height: constraints.maxHeight*0.05,
                              width: constraints.maxHeight*0.05,
                              color: Color.fromARGB(255, 136, 255, 0),
                            ),
                          ),
                          Text(" Running", style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05),),
                        ],
                      ),
                      SizedBox(height: constraints.maxHeight*0.008,),
                      Text("Processed Unit : 50",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05)),
                      SizedBox(height: constraints.maxHeight*0.008,),
                      Text("Flawless Unit : 50",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05)),
                      SizedBox(height: constraints.maxHeight*0.008,),
                      Text("Defect Unit : 50",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05)),
                      
                    ],
                  ),
                ),
                //Mesin 2----------------------------------------------------------
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  height: constraints.maxHeight * 0.45,
                  width: constraints.maxWidth * 0.9,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 176, 7, 255),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,5),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, mym2monitoring, arguments: "from dash");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Mesin 2", style: TextStyle(
                                  color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold
                                  ),
                                ),
                                Icon(FontAwesomeIcons.angleRight,color: Colors.white, )
                              ],
                            ),
                          ),
                        ),   
                      Container(
                        height: 2,
                        width: constraints.maxWidth*0.9,
                        color: Color.fromARGB(255, 230, 69, 217),
                      ),
                      SizedBox(height: constraints.maxHeight*0.025,),
                      Row(
                        children: [
                          Text("Status Mesin : ", style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05),),
                          ClipOval(
                            child: Container(
                              height: constraints.maxHeight*0.05,
                              width: constraints.maxHeight*0.05,
                              color: Color.fromARGB(255, 136, 255, 0),
                            ),
                          ),
                          Text(" Running", style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05),),
                        ],
                      ),
                      SizedBox(height: constraints.maxHeight*0.008,),
                      Text("Processed Unit : 50",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05)),
                      SizedBox(height: constraints.maxHeight*0.008,),
                      Text("Flawless Unit : 50",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05)),
                      SizedBox(height: constraints.maxHeight*0.008,),
                      Text("Defect Unit : 50",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05)),
                      
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
            ],
          ),
        ),
      ),
    );
  }

  // CONTENT PRODUCTION MONITORING----------------------------------------------------------------------------------------------------------------
  Widget contentproduction(
    BuildContext context,
  ) {
    // UNTUK LEBAR TAMPILAN
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;

    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return ClipRRect(
      borderRadius: BorderRadius.circular(blockVertical * 3),
      child: Container(
        margin: EdgeInsets.fromLTRB(blockHorizontal * 0.1, blockVertical * 0.01,
            blockHorizontal * 0.1, blockVertical * 0.01),
        width: blockHorizontal * 85,
        height: blockVertical * 87 / 2,
        color: Colors.transparent,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //Mesin 1----------------------------------------------------------
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  height: constraints.maxHeight * 0.45,
                  width: constraints.maxWidth * 0.9,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 7, 197, 255),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,5),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, mym1monitoring, arguments: "from dash");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Mesin 1", style: TextStyle(
                                  color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold
                                  ),
                                ),
                                Icon(FontAwesomeIcons.angleRight,color: Colors.white, )
                              ],
                            ),
                          ),
                        ),   
                      Container(
                        height: 2,
                        width: constraints.maxWidth*0.9,
                        color: Colors.lightBlue,
                      ),
                      SizedBox(height: constraints.maxHeight*0.025,),
                      Row(
                        children: [
                          Text("Status Mesin : ", style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05),),
                          ClipOval(
                            child: Container(
                              height: constraints.maxHeight*0.05,
                              width: constraints.maxHeight*0.05,
                              color: Color.fromARGB(255, 136, 255, 0),
                            ),
                          ),
                          Text(" Running", style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05),),
                        ],
                      ),
                      SizedBox(height: constraints.maxHeight*0.008,),
                      Text("Processed Unit : 50",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05)),
                      SizedBox(height: constraints.maxHeight*0.008,),
                      Text("Flawless Unit : 50",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05)),
                      SizedBox(height: constraints.maxHeight*0.008,),
                      Text("Defect Unit : 50",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05)),
                      
                    ],
                  ),
                ),
                //Mesin 2----------------------------------------------------------
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  height: constraints.maxHeight * 0.45,
                  width: constraints.maxWidth * 0.9,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 176, 7, 255),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,5),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, mym2monitoring, arguments: "from dash");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Mesin 2", style: TextStyle(
                                  color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold
                                  ),
                                ),
                                Icon(FontAwesomeIcons.angleRight,color: Colors.white, )
                              ],
                            ),
                          ),
                        ),   
                      Container(
                        height: 2,
                        width: constraints.maxWidth*0.9,
                        color: Color.fromARGB(255, 230, 69, 217),
                      ),
                      SizedBox(height: constraints.maxHeight*0.025,),
                      Row(
                        children: [
                          Text("Status Mesin : ", style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05),),
                          ClipOval(
                            child: Container(
                              height: constraints.maxHeight*0.05,
                              width: constraints.maxHeight*0.05,
                              color: Color.fromARGB(255, 136, 255, 0),
                            ),
                          ),
                          Text(" Running", style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05),),
                        ],
                      ),
                      SizedBox(height: constraints.maxHeight*0.008,),
                      Text("Processed Unit : 50",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05)),
                      SizedBox(height: constraints.maxHeight*0.008,),
                      Text("Flawless Unit : 50",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05)),
                      SizedBox(height: constraints.maxHeight*0.008,),
                      Text("Defect Unit : 50",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05)),
                      
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
    Widget contentproduction2(
    BuildContext context,
  ) {
    // UNTUK LEBAR TAMPILAN
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;

    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(context).size.height;
    double blockVertical = MediaQueryheight / 100;
    return ClipRRect(
      borderRadius: BorderRadius.circular(blockVertical * 3),
      child: Container(
        margin: EdgeInsets.fromLTRB(blockHorizontal * 0.1, blockVertical * 0.01,
            blockHorizontal * 0.1, blockVertical * 0.01),
        width: blockHorizontal * 85,
        height: blockVertical * 87 / 2,
        color: Colors.transparent,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //MESIN 3-------------------------------------------------------------
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  height: constraints.maxHeight * 0.45,
                  width: constraints.maxWidth * 0.9,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 88, 230, 69),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,5),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, mym3monitoring, arguments: "from dash");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Mesin 3", style: TextStyle(
                                  color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold
                                  ),
                                ),
                                Icon(FontAwesomeIcons.angleRight,color: Colors.white, )
                              ],
                            ),
                          ),
                        ),   
                      Container(
                        height: 2,
                        width: constraints.maxWidth*0.9,
                        color: Color.fromARGB(255, 119, 244, 3),
                      ),
                      SizedBox(height: constraints.maxHeight*0.025,),
                      Row(
                        children: [
                          Text("Status Mesin : ", style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05),),
                          ClipOval(
                            child: Container(
                              height: constraints.maxHeight*0.05,
                              width: constraints.maxHeight*0.05,
                              color: Color.fromARGB(255, 136, 255, 0),
                            ),
                          ),
                          Text(" Running", style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05),),
                        ],
                      ),
                      SizedBox(height: constraints.maxHeight*0.008,),
                      Text("Processed Unit : 50",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05)),
                      SizedBox(height: constraints.maxHeight*0.008,),
                      Text("Flawless Unit : 50",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05)),
                      SizedBox(height: constraints.maxHeight*0.008,),
                      Text("Defect Unit : 50",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05)),
                      
                    ],
                  ),
                ),
                //Mesin 4----------------------------------------------------------
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  height: constraints.maxHeight * 0.45,
                  width: constraints.maxWidth * 0.9,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 7, 214),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10,10,10,5),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, mym4monitoring, arguments: "from dash");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Mesin 4", style: TextStyle(
                                  color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold
                                  ),
                                ),
                                Icon(FontAwesomeIcons.angleRight,color: Colors.white, )
                              ],
                            ),
                          ),
                        ),   
                      Container(
                        height: 2,
                        width: constraints.maxWidth*0.9,
                        color: Color.fromARGB(255, 230, 69, 217),
                      ),
                      SizedBox(height: constraints.maxHeight*0.025,),
                      Row(
                        children: [
                          Text("Status Mesin : ", style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05),),
                          ClipOval(
                            child: Container(
                              height: constraints.maxHeight*0.05,
                              width: constraints.maxHeight*0.05,
                              color: Color.fromARGB(255, 136, 255, 0),
                            ),
                          ),
                          Text(" Running", style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05),),
                        ],
                      ),
                      SizedBox(height: constraints.maxHeight*0.008,),
                      Text("Processed Unit : 50",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05)),
                      SizedBox(height: constraints.maxHeight*0.008,),
                      Text("Flawless Unit : 50",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05)),
                      SizedBox(height: constraints.maxHeight*0.008,),
                      Text("Defect Unit : 50",style: TextStyle(color: Colors.white, fontSize: constraints.maxHeight*0.05)),
                      
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
