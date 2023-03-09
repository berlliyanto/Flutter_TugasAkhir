// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
String level = "Super Admin";

  MainDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return (level == 'Super Admin')
        ? adminDrawer(context)
        : userDrawer(context);
  }

//drawer untuk super admin, terdapat user list
  Drawer userDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text(
                'username',
                style: TextStyle(color: Colors.black),
              ),
              accountEmail: Text(level, style: TextStyle(color: Colors.black)),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFFF3EDDF),
                Color(0xFFF3EDDF),
              ], begin: Alignment.bottomLeft, end: Alignment.topRight))),
          buildList((context), 'm1home', Icons.monitor, "Mesin 1"),
          buildList((context), 'm2home', Icons.monitor, "Mesin 2"),
          buildList((context), 'm3home', Icons.monitor, "Mesin 3"),
          buildList((context), 'm4home', Icons.monitor, "Mesin 4"),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            title: Text("Close", style: TextStyle(fontSize: 16)),
            leading: Icon(Icons.close),
          )
        ],
      ),
    );
  }

//drawer untuk user selain super admin, tidak terdapat user list
  Drawer adminDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
              accountName:
                  Text("username", style: TextStyle(color: Colors.black)),
              accountEmail: Text(level, style: TextStyle(color: Colors.black)),
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFFF3EDDF),
                Color(0xFFF3EDDF),
              ], begin: Alignment.bottomLeft, end: Alignment.topRight))),
          buildList((context), '/m1home', Icons.monitor, "Mesin 1"),
          buildList((context), '/m2home', Icons.monitor, "Mesin 2"),
          buildList((context), '/m3home', Icons.monitor, "Mesin 3"),
          buildList((context), '/m4home', Icons.monitor, "Mesin 4"),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/akun',
                  arguments: {'username': "username", 'level': "level"});
            },
            title: Text("User", style: TextStyle(fontSize: 16)),
            leading: Icon(Icons.supervised_user_circle),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pop();
            },
            title: Text("Close", style: TextStyle(fontSize: 16)),
            leading: Icon(Icons.close),
          )
        ],
      ),
    );
  }

  ListTile buildList(
      BuildContext context, String routeName, IconData iconData, String text) {
    return ListTile(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(routeName,
            arguments: {'username': "username", 'level': "level"});
      },
      title: Text(text, style: TextStyle(fontSize: 16)),
      leading: Icon(iconData),
    );
  }
}
