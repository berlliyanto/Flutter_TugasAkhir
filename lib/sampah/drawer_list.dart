//drawer list
import 'package:flutter/material.dart';

class Drawerlist extends StatefulWidget {
  const Drawerlist({super.key});

  @override
  State<Drawerlist> createState() => _DrawerlistState();
}

class _DrawerlistState extends State<Drawerlist> {
  var currentpage = DrawerSections.isidashboard;
  // static Route<dynamic> generateRoute(RouteSettings settings);
  // final args = settings.arguments;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          menuItem(
              (context),
              1,
              "Dashboard",
              Icons.dashboard_outlined,
              '/dashboard',
              currentpage == DrawerSections.isidashboard ? true : false),
          menuItem(
              (context),
              2,
              "Mesin 1",
              Icons.precision_manufacturing_outlined,
              '/m1home',
              currentpage == DrawerSections.mesin1 ? true : false),
          menuItem(
              (context),
              3,
              "Mesin 2",
              Icons.precision_manufacturing_outlined,
              '/m2home',
              currentpage == DrawerSections.mesin2 ? true : false),
          menuItem(
              (context),
              4,
              "Mesin 3",
              Icons.precision_manufacturing_outlined,
              '/m3home',
              currentpage == DrawerSections.mesin3 ? true : false),
          menuItem(
              (context),
              5,
              "Mesin 4",
              Icons.precision_manufacturing_outlined,
              '/m4home',
              currentpage == DrawerSections.mesin4 ? true : false),
          menuItem(
              (context),
              6,
              "Preventive Maintenance",
              Icons.settings_outlined,
              '/preventive',
              currentpage == DrawerSections.setting ? true : false),
          menuItem((context), 
              7, "Kelola Akun", 
              Icons.account_box_outlined,
              '/akun', 
              currentpage == DrawerSections.kelolaakun ? true : false),
          menuItem((context),
              8, "Log Out", 
              Icons.logout_outlined, 
              '/login',
              currentpage == DrawerSections.logout ? true : false),
          ListTile(
            leading: Icon(Icons.close),
            title: Text(
              "Close",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  ListTile menuItem(BuildContext context, int id, String title, IconData icon,
      String routeName, bool selected) {
    return ListTile(
      leading: Icon(
        icon,
        size: 18,
        color: Colors.black,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 20),
        overflow: TextOverflow.ellipsis,
      ),
      // color: selected ? Colors.grey[300] : Colors.transparent,
      // child: InkWell(
      onTap: (() {
        Navigator.of(context).pushReplacementNamed(routeName);
        setState(() {
          if (id == 1) {
            currentpage = DrawerSections.isidashboard;
          } else if (id == 2) {
            currentpage = DrawerSections.mesin1;
          } else if (id == 3) {
            currentpage = DrawerSections.mesin2;
          } else if (id == 4) {
            currentpage = DrawerSections.mesin3;
          } else if (id == 5) {
            currentpage = DrawerSections.mesin4;
          } else if (id == 6) {
            currentpage = DrawerSections.setting;
          } else if (id == 7) {
            currentpage = DrawerSections.kelolaakun;
          } else if (id == 8) {
            currentpage = DrawerSections.logout;
          }
          print(currentpage);
        });
      }
          // child: Padding(
          //   padding: EdgeInsets.all(15),
          //   child: Row(
          //     children: [
          //       Container(
          //         padding: EdgeInsets.only(left: 10),
          //         child: Icon(
          //           icon,
          //           size: 18,
          //           color: Colors.black,
          //         ),
          //       ),
          //       Container(
          //           padding: EdgeInsets.only(left: 30),
          //           child: Text(
          //             title,
          //             style: TextStyle(color: Colors.black, fontSize: 20),
          //             overflow: TextOverflow.ellipsis,
          //           ))
          //     ],
          //   ),
          // ),
          ),
    );
  }
}

enum DrawerSections {
  isidashboard,
  mesin1,
  mesin2,
  mesin3,
  mesin4,
  setting,
  kelolaakun,
  logout,
}
