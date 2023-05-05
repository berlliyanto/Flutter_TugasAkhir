import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/costprice_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/costprice_service.dart';

class m1pricelist extends StatefulWidget {
  static const nameRoute = '/m1price';
  const m1pricelist({super.key});

  @override
  State<m1pricelist> createState() => _m1pricelistState();
}

class _m1pricelistState extends State<m1pricelist> {
  TextEditingController Material1 = TextEditingController();
  TextEditingController Material2 = TextEditingController();
  TextEditingController Material3 = TextEditingController();
  bool editMode = false;
  String editType = "A";
  late Timer timer;
  StreamController streamPrice = StreamController.broadcast();
  List<getPriceModel> priceList = [];
  getPrice getPriceLIST = getPrice();
  Future<void> priceData() async {
    priceList = await getPriceLIST.getPriceList();
    streamPrice.add(priceList);
  }

  @override
  void initState() {
    priceData();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      priceData();
    });
    super.initState();
  }

  @override
  void dispose() {
    if (timer.isActive) timer.cancel();
    super.dispose();
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
      padding: EdgeInsets.symmetric(
          vertical: blockVertical * 1.5, horizontal: blockHorizontal * 2),
      child: StreamBuilder(
        stream: streamPrice.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: priceList.map((e) {
                  return Card(
                    color: Colors.white,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(blockVertical * 1))),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: blockVertical * 1,
                          horizontal: blockHorizontal * 2),
                      height: blockVertical * 40,
                      width: MediaQuerywidth,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Type ${e.tipe}",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 65, 60, 60),
                                        fontSize: constraints.maxHeight * 0.1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.penToSquare,
                                      size: constraints.maxHeight * 0.1,
                                      color: Color.fromARGB(255, 65, 60, 60),
                                    ),
                                  )
                                ],
                              ),
                              Divider(
                                thickness: constraints.maxHeight * 0.01,
                              ),
                              Text(
                                "Raw Material :",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 65, 60, 60),
                                    fontSize: constraints.maxHeight * 0.07,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: constraints.maxHeight * 0.03,
                                    horizontal: constraints.maxWidth * 0.03),
                                height: constraints.maxHeight * 0.5,
                                width: constraints.maxWidth,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(255, 173, 173, 173)
                                              .withOpacity(0.5),
                                          Color.fromARGB(255, 121, 121, 121)
                                              .withOpacity(0.5)
                                        ],
                                        end: Alignment.topLeft,
                                        begin: Alignment.bottomRight),
                                    borderRadius: BorderRadius.circular(
                                        constraints.maxHeight * 0.05)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Material ${e.Nbaku1} : ",
                                          style: TextStyle(
                                              fontSize:
                                                  constraints.maxHeight * 0.07,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 65, 60, 60)),
                                        ),
                                        Text(
                                          "Rp. ${e.Pbaku1},-",
                                          style: TextStyle(
                                              fontSize:
                                                  constraints.maxHeight * 0.07,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 65, 60, 60)),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Material ${e.Nbaku2} : ",
                                          style: TextStyle(
                                              fontSize:
                                                  constraints.maxHeight * 0.07,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 65, 60, 60)),
                                        ),
                                        Text(
                                          "Rp. ${e.Pbaku2},-",
                                          style: TextStyle(
                                              fontSize:
                                                  constraints.maxHeight * 0.07,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 65, 60, 60)),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Material ${e.Nbaku3} : ",
                                          style: TextStyle(
                                              fontSize:
                                                  constraints.maxHeight * 0.07,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 65, 60, 60)),
                                        ),
                                        Text(
                                          "Rp. ${e.Pbaku3},-",
                                          style: TextStyle(
                                              fontSize:
                                                  constraints.maxHeight * 0.07,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 65, 60, 60)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.01,
                              ),
                              Divider(
                                thickness: constraints.maxHeight * 0.01,
                              ),
                              SizedBox(
                                height: constraints.maxHeight * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Price : ",
                                    style: TextStyle(
                                      fontSize: constraints.maxHeight * 0.08,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 65, 60, 60),
                                    ),
                                  ),
                                  Text(
                                    "Rp. ${e.Ptotal},-",
                                    style: TextStyle(
                                      fontSize: constraints.maxHeight * 0.08,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 65, 60, 60),
                                    ),
                                  )
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Colors.grey,
                child: Text(
                  'Loading',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: blockVertical * 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
          return Center(
            child: Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey,
              child: Text(
                'Loading',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: blockVertical * 5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
