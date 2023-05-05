import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes.dart';

class editprice extends StatefulWidget {
  const editprice({super.key});

  @override
  State<editprice> createState() => _editpriceState();
}

class _editpriceState extends State<editprice> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute,
      home: Scaffold(
        
      ),
    );
  }
}