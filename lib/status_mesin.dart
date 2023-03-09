import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/status_service.dart';
import 'package:flutter_application_1/models/status_model.dart';

class statusMesin extends StatefulWidget {
  const statusMesin({super.key});

  @override
  State<statusMesin> createState() => _statusMesinState();
}

class _statusMesinState extends State<statusMesin> {
    late Timer timer;
  // STREAMCONTROLLER MESIN 1
  StreamController<List> streamStatusM1 = StreamController();
  List<statusModel> status = [];
  getStatusM1 statusState = getStatusM1();
  Future<void> getStatus() async {
    status = await getStatusM1.readStatM1();
    streamStatusM1.add(status);
  }

  // STREAMCONTROLLER MESIN 2
  StreamController<List> streamStatusM2 = StreamController();
  List<status2Model> status2 = [];
  getStatusM2 statusState2 = getStatusM2();
  Future<void> getStatus2() async {
    status2 = await getStatusM2.readStatM2();
    streamStatusM2.add(status);
  }

  // STREAMCONTROLLER MESIN 3
  StreamController<List> streamStatusM3 = StreamController();
  List<status3Model> status3 = [];
  getStatusM3 statusState3 = getStatusM3();
  Future<void> getStatus3() async {
    status3 = await getStatusM3.readStatM3();
    streamStatusM3.add(status);
  }

  // STREAMCONTROLLER MESIN 4
  StreamController<List> streamStatusM4 = StreamController();
  List<status4Model> status4 = [];
  getStatusM4 statusState4 = getStatusM4();
  Future<void> getStatus4() async {
    status4 = await getStatusM4.readStatM4();
    streamStatusM4.add(status);
  }

  @override
  void initState() {
    getStatus();
    getStatus2();
    getStatus3();
    getStatus4();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      getStatus();
      getStatus2();
      getStatus3();
      getStatus4();
    });
    super.initState();
  }
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
                              blockHorizontal * 4,
                              blockVertical * 4,
                              blockHorizontal * 4,
                              blockVertical * 1),
                          child: Container(
                            height: MediaQueryheight * 0.15,
                            width: MediaQuerywidth,
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5,
                                    color: Color.fromARGB(255, 0, 0, 0)
                                        .withOpacity(0.7),
                                    offset: Offset(3, 3))
                              ],
                            ),

                            // Content Status Mesin----------------------------------------------------------------------------------------------------------------
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: blockHorizontal * 1.2,
                                          top: blockVertical * 4),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: MediaQueryheight * 0.035,
                                            width: MediaQuerywidth * 0.435,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 5,
                                                      color: Color.fromARGB(
                                                              255, 0, 0, 0)
                                                          .withOpacity(0.7),
                                                      offset: Offset(3, 3))
                                                ]),
                                            child: StreamBuilder(
                                                stream: streamStatusM1.stream,
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return Column(
                                                      mainAxisAlignment:MainAxisAlignment.center,
                                                      children: status.map((e) {
                                                        return Center(
                                                          child: Text((e.status==1)?
                                                              "Mesin ${e.machine_id} is Connected": "Mesin ${e.machine_id} Not Connected",
                                                              style: TextStyle(fontSize:MediaQueryheight *0.018,
                                                                color: (e.status==1)? Color.fromARGB(255, 0, 245, 126) : Colors.redAccent
                                                              ),
                                                            ),
                                                        );
                                                      }).toList(),
                                                    );
                                                  } else if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  }
                                                  return Text("error");
                                                }),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: blockHorizontal * 1.2),
                                            child: Container(
                                              height: MediaQueryheight * 0.035,
                                              width: MediaQuerywidth * 0.435,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 5,
                                                        color: Color.fromARGB(
                                                                255, 0, 0, 0)
                                                            .withOpacity(0.7),
                                                        offset: Offset(3, 3))
                                                  ]),
                                              child: StreamBuilder(
                                                stream: streamStatusM2.stream,
                                                builder: (context, snapshot) {
                                                  if(snapshot.hasData){
                                                    return Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: status2.map((a) {
                                                        return Center(
                                                        child: Text((a.status==1)?
                                                              "Mesin ${a.machine_id} is Connected": "Mesin ${a.machine_id} Not Connected",
                                                              style: TextStyle(fontSize:MediaQueryheight *0.018,
                                                                color: (a.status==1)? Color.fromARGB(255, 0, 245, 126) : Colors.redAccent
                                                              ),
                                                            ),
                                                        );
                                                      }).toList(),  
                                                    );
                                                  }else if(snapshot.connectionState==ConnectionState.waiting){
                                                    return Center(
                                                      child: CircularProgressIndicator(),
                                                    );
                                                  }
                                                  return Text("Error");
                                                }
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: blockHorizontal * 1.2,
                                          top: blockVertical * 0.7),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: MediaQueryheight * 0.035,
                                            width: MediaQuerywidth * 0.435,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 5,
                                                      color: Color.fromARGB(
                                                              255, 0, 0, 0)
                                                          .withOpacity(0.7),
                                                      offset: Offset(3, 3))
                                                ]),
                                            child: StreamBuilder(
                                                stream: streamStatusM3.stream,
                                                builder: (context, snapshot) {
                                                  if(snapshot.hasData){
                                                    return Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: status3.map((a) {
                                                        return Center(
                                                        child: Text((a.status==1)?
                                                              "Mesin ${a.machine_id} is Connected": "Mesin ${a.machine_id} Not Connected",
                                                              style: TextStyle(fontSize:MediaQueryheight *0.018,
                                                                color: (a.status==1)? Color.fromARGB(255, 0, 245, 126) : Colors.redAccent
                                                              ),
                                                            ),
                                                        );
                                                      }).toList(),  
                                                    );
                                                  }else if(snapshot.connectionState==ConnectionState.waiting){
                                                    return Center(
                                                      child: CircularProgressIndicator(),
                                                    );
                                                  }
                                                  return Text("Error");
                                                }
                                              ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: blockHorizontal * 1.2,
                                                top: 0),
                                            child: Container(
                                              height: MediaQueryheight * 0.035,
                                              width: MediaQuerywidth * 0.435,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 5,
                                                        color: Color.fromARGB(
                                                                255, 0, 0, 0)
                                                            .withOpacity(0.7),
                                                        offset: Offset(3, 3))
                                                  ]),
                                              child: StreamBuilder(
                                                stream: streamStatusM4.stream,
                                                builder: (context, snapshot) {
                                                  if(snapshot.hasData){
                                                    return Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: status4.map((a) {
                                                        return Center(
                                                        child: Text((a.status==1)?
                                                              "Mesin ${a.machine_id} is Connected": "Mesin ${a.machine_id} Not Connected",
                                                              style: TextStyle(fontSize:MediaQueryheight *0.018,
                                                                color: (a.status==1)? Color.fromARGB(255, 0, 245, 126) : Colors.redAccent
                                                              ),
                                                            ),
                                                        );
                                                      }).toList(),  
                                                    );
                                                  }else if(snapshot.connectionState==ConnectionState.waiting){
                                                    return Center(
                                                      child: CircularProgressIndicator(),
                                                    );
                                                  }
                                                  return Text("Error");
                                                }
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
  }
}