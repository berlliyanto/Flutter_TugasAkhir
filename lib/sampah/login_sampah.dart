// ignore_for_file: unused_local_variable, sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/login_service.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/models/login_model.dart';

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

    // UNTUK TINGGI TAMPILAN
    final MediaQueryheight = MediaQuery.of(context).size.height;
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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //BODY----------------------------------------------------------------------------------------------------------------
        body: Stack(
          children: [
            //BACKGROUND----------------------------------------------------------------------------------------------------------------
            Container(
              height: MediaQueryheight,
              width: MediaQuerywidth,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF3ac3cb),
                      Color(0xFFFFFFFF),
                    ]),
                image: DecorationImage(
                    image: AssetImage("images/asset6.png"), fit: BoxFit.fill),
              ),
            ),
            Container(
              height: MediaQueryheight,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(15, 100, 15, 30),
                child: Center(
                  //TITLE----------------------------------------------------------------------------------------------------------------
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.computer,
                        size: MediaQueryheight * 0.1,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(5, 2),
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ],
                      ),
                      
                      SizedBox(height: MediaQueryheight * 0.12),
                      Text(
                        "Welcome To",
                        style: TextStyle(
                          fontSize: MediaQueryheight * 0.02,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 3),
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQueryheight * 0.009,
                      ),
                      Text(
                        "Production Monitoring System",
                        style: TextStyle(
                          fontSize: MediaQueryheight * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 3),
                              color: Colors.black.withOpacity(0.1),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: MediaQueryheight * 0.05,
                      ),

                      // Email----------------------------------------------------------------------------------------------------------------
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: MediaQueryheight * 0.06,
                          width: MediaQuerywidth,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            border: Border.all(
                              color: Colors.blueGrey.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.withOpacity(0.05),
                                offset: Offset(2, 2),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Form(
                            autovalidateMode: AutovalidateMode.always,
                            child: TextField(
                              controller: Username,
                              style:
                                  TextStyle(fontSize: MediaQueryheight * 0.021),
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
                      ),

                      // Password----------------------------------------------------------------------------------------------------------------
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: MediaQueryheight * 0.06,
                          width: MediaQuerywidth,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            border: Border.all(
                              color: Colors.blueGrey.withOpacity(0.5),
                            ),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.withOpacity(0.05),
                                offset: Offset(2, 2),
                                blurRadius: 2,
                              ),
                            ],
                          ),
                          child: Form(
                            autovalidateMode: AutovalidateMode.always,
                            child: TextField(
                              controller: Password,
                              textAlignVertical: TextAlignVertical.center,
                              style:
                                  TextStyle(fontSize: MediaQueryheight * 0.021),
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
                      ),
                      SizedBox(
                        height: MediaQueryheight * 0.01,
                      ),

                      // Button Login----------------------------------------------------------------------------------------------------------------
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: MediaQuerywidth,
                            height: MediaQueryheight * 0.06,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    begin: Alignment.topRight,
                                    end: Alignment.bottomLeft,
                                    colors: [
                                      Color.fromARGB(214, 1, 41, 44),
                                      Color.fromARGB(235, 2, 141, 146)
                                    ])),
                            child: Material(
                              type: MaterialType.canvas,
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              child: InkWell(
                                splashColor: Color.fromARGB(19, 3, 191, 233),
                                radius: 100,
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  if (Username.text.isNotEmpty ||
                                      Password.text.isNotEmpty) {
                                    loginRequestModel model = loginRequestModel(
                                      username: Username.text,
                                      password: Password.text,
                                    );
                                    LoginService.login(model).then((value) => {
                                          if (value)
                                            {
                                              Navigator.pushReplacementNamed(
                                                  context, mytransisi,
                                                  arguments: "arg"),
                                            }
                                          else
                                            {
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.error,
                                                animType: AnimType.leftSlide,
                                                title: "Error",
                                                desc:
                                                    "Username atau Password Salah !",
                                                autoHide: Duration(seconds: 2),
                                              ).show()
                                            }
                                        });
                                  } else {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      animType: AnimType.leftSlide,
                                      title: "Error",
                                      desc: "Username atau Password Salah !",
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
                      SizedBox(
                        height: MediaQueryheight * 0.11,
                      ),

                      Center(
                        child: Container(
                          height: MediaQueryheight * 0.1,
                          width: MediaQuerywidth * 0.3,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/asset7.png"),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 70),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
