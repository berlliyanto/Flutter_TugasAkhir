import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes.dart';


class editprice extends StatefulWidget {
  const editprice(String av,{super.key});

  @override
  State<editprice> createState() => _editpriceState();
}

class _editpriceState extends State<editprice> {
  String tipe = "";
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final routeData = ModalRoute.of(context)!.settings.arguments as String;
    print(routeData);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      home: Scaffold(
        body: Center(
          child: Text(""),
        ),
      ),
    );
  }
}
