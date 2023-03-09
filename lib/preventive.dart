// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_application_1/drawer.dart';
import 'package:flutter_application_1/routes.dart';


class preventive extends StatefulWidget {
  static const nameRoute = '/preventive';

  const preventive(String h, {super.key});

  @override
  State<preventive> createState() => _preventiveState();
}

class _preventiveState extends State<preventive> {
  bool stateSwitch = false;
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      home: Scaffold(
        appBar: AppBar(),
        drawer: drawer(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("s"),
            Center(
              child: ElevatedButton(onPressed: (){
              },
              child: Text("data"),),
            ),
          ],
        ),
      ),
    );
  }
}

