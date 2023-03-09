// ignore_for_file: unused_local_variable, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/login_service.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/login_model.dart';
import 'package:lottie/lottie.dart';


class login extends StatefulWidget {
  static const nameRoute = '/login';

  const login(String d, {super.key});
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool _showpass = true;
  bool isAPIcallProcess = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late String? username;
  late String? password;

  TextEditingController Username = TextEditingController();
  TextEditingController Password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // UNTUK LEBAR TAMPILAN
    final MediaQuerywidth = MediaQuery.of(context).size.width;
    double blockHorizontal = MediaQuerywidth / 100;
    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(context).size.height;
     double blockVertical = MediaQueryheight / 100;
    // Mengetahui Orientasi Device
    final bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          //BODY----------------------------------------------------------------------------------------------------------------
          body: Container(
        padding: EdgeInsets.symmetric(horizontal: MediaQuerywidth * 0.05, vertical: blockVertical*2.5),
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.blue,
            image: DecorationImage(
                image: AssetImage("images/asset24.jpg"), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, mygetstarted, arguments: "from login");
                  }, icon: Icon(Icons.keyboard_arrow_left, size: MediaQueryheight*0.05,color: Colors.white,)),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: blockVertical*7,bottom: blockVertical*3),
                height: MediaQueryheight*0.25,
                width: MediaQuerywidth*0.7,
                child: Lottie.asset("lottie/user.json")
                ),
                Text("LOGIN", style: TextStyle(color: Colors.white, fontSize: MediaQueryheight*0.07, fontWeight: FontWeight.bold),),
                SizedBox(height: MediaQueryheight*0.01,),
                ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: MediaQuerywidth,
                  height: MediaQueryheight * 0.4,
                  color: Colors.transparent,
                  child: Stack(children: [
                    //blurEffect
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                      child: Container(),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.13),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.15),
                            Colors.white.withOpacity(0.5)
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(blockHorizontal*2.5, blockHorizontal*2.5, blockHorizontal*1.25, blockHorizontal*1.25),
                            child: Text("Masukkan Username", style: TextStyle(color: Colors.white, fontSize: MediaQueryheight*0.02, fontWeight: FontWeight.bold),),
                          ),
                          //EMAIL---------------------------------------------------------------------------
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: MediaQueryheight * 0.08,
                              width: MediaQuerywidth,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                border: Border.all(
                                  color: Colors.blueGrey.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey.withOpacity(0.05),
                                    offset: Offset(2, 2),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: Username,
                                style: TextStyle(
                                    fontSize: MediaQueryheight * 0.021),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Username",
                                  prefixIcon: Icon(
                                    Icons.person_rounded,
                                    size: MediaQueryheight * 0.035,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQueryheight * 0.01,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(blockHorizontal*2.5, 0, blockHorizontal*1.25, blockHorizontal*1.25),
                            child: Text("Masukkan Password", style: TextStyle(color: Colors.white, fontSize: MediaQueryheight*0.02, fontWeight: FontWeight.bold),),
                          ),
                          // Password----------------------------------------------------------------------------------------------------------------
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: MediaQueryheight * 0.08,
                              width: MediaQuerywidth,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                border: Border.all(
                                  color: Colors.blueGrey.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey.withOpacity(0.05),
                                    offset: Offset(2, 2),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: Password,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                    fontSize: MediaQueryheight * 0.021),
                                obscureText: _showpass,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    size: MediaQueryheight * 0.035,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _showpass = !_showpass;
                                      });
                                    },
                                    icon: Icon(
                                      _showpass
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      size: MediaQueryheight * 0.035,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQueryheight * 0.03,
                          ),

                          // Button Login----------------------------------------------------------------------------------------------------------------
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: blockHorizontal*1.25),
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: MediaQuerywidth,
                                height: MediaQueryheight * 0.08,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color.fromARGB(212, 2, 84, 122),
                                          Color.fromARGB(235, 14, 61, 99)
                                        ])),
                                child: Material(
                                  type: MaterialType.canvas,
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  child: InkWell(
                                    splashColor:
                                        Color.fromARGB(19, 3, 191, 233),
                                    radius: 100,
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () {
                                      if (Username.text.isNotEmpty ||
                                          Password.text.isNotEmpty) {
                                        loginRequestModel model =
                                            loginRequestModel(
                                          username: Username.text,
                                          password: Password.text,
                                        );
                                        LoginService.login(model)
                                            .then((value) => {
                                                  if (value)
                                                    {
                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              mytransisi,
                                                              arguments: "arg"),
                                                    }
                                                  else
                                                    {
                                                      AwesomeDialog(
                                                        context: context,
                                                        dialogType:
                                                            DialogType.error,
                                                        animType:
                                                            AnimType.leftSlide,
                                                        title: "Error",
                                                        desc:
                                                            "Username atau Password Salah !",
                                                        autoHide: Duration(
                                                            seconds: 2),
                                                      ).show()
                                                    }
                                                });
                                      } else {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.error,
                                          animType: AnimType.leftSlide,
                                          title: "Error",
                                          desc:
                                              "Username atau Password Salah !",
                                          autoHide: Duration(seconds: 2),
                                        ).show();
                                      }
                                    },
                                    child: Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            fontSize: MediaQueryheight * 0.028,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
