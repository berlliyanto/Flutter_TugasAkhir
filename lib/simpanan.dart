
// Card Status Mesin
// child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.only(top: 45, left: 5),
//                                     child: Container(
//                                       height: 20,
//                                       width: 50,
//                                         child: Row(
//                                       children: [
//                                         Text("Mesin 1 :"),
//                                       ],
//                                     )),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(top: 45, left: 5),
//                                     child: FutureBuilder(
//                                       future: MongoDatabase.getData(),
//                                       builder:
//                                           (context, AsyncSnapshot snapshot) {
//                                         if (snapshot.connectionState ==
//                                             ConnectionState.waiting) {
//                                           return Center(
//                                             child: CircularProgressIndicator(),
//                                           );
//                                         } else {
//                                           if (snapshot.hasData) {
//                                             var totalData =
//                                                 snapshot.data.length;
//                                             print(totalData);
//                                             return Container(
//                                                 child: Text(
//                                               "Not Connected",
//                                               style: TextStyle(
//                                                   color: Colors.green),
//                                             ));
//                                           } else {
//                                             return Container(
//                                               child: Text("Not Connected"),
//                                             );
//                                           }
//                                         }
//                                       },
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(top: 45, left: 5),
//                                     child: Text("Mesin 2 :"),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(top: 45, left: 5),
//                                     child: Text("Not Connected"),
//                                   )
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.only(top: 20, left: 5),
//                                     child: Text("Mesin 3 :"),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(top: 20, left: 5),
//                                     child: Text("Not Connected"),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(top: 20, left: 5),
//                                     child: Text("Mesin 4 :"),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.only(top: 20, left: 5),
//                                     child: Text("Not Connected"),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),

//drawer list
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/dashboard.dart';
// import 'package:flutter_application_1/mesin1/m1home.dart';

// class Drawerlist extends StatefulWidget {
//   const Drawerlist({super.key});

//   @override
//   State<Drawerlist> createState() => _DrawerlistState();
// }

// class _DrawerlistState extends State<Drawerlist> {
//   var currentpage = DrawerSections.isidashboard;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: 15),
//       child: Column(
//         children: [
//           menuItem(1, "Dashboard", Icons.dashboard_outlined,
//               currentpage == DrawerSections.isidashboard ? true : false),
//           menuItem(2, "Mesin 1", Icons.precision_manufacturing_outlined,
//               currentpage == DrawerSections.mesin1 ? true : false),
//           menuItem(3, "Mesin 2", Icons.precision_manufacturing_outlined,
//               currentpage == DrawerSections.mesin2 ? true : false),
//           menuItem(4, "Mesin 3", Icons.precision_manufacturing_outlined,
//               currentpage == DrawerSections.mesin3 ? true : false),
//           menuItem(5, "Mesin 4", Icons.precision_manufacturing_outlined,
//               currentpage == DrawerSections.mesin4 ? true : false),
//           menuItem(6, "Pengaturan", Icons.settings_outlined,
//               currentpage == DrawerSections.setting ? true : false),
//           menuItem(7, "Kelola Akun", Icons.account_box_outlined,
//               currentpage == DrawerSections.kelolaakun ? true : false),
//           menuItem(8, "Log Out", Icons.logout_outlined,
//               currentpage == DrawerSections.logout ? true : false),
//         ],
//       ),
//     );
//   }

//   Widget menuItem(int id, String title, IconData icon, bool selected) {
//     return Material(
//       color: selected ? Colors.grey[300] : Colors.transparent,
//       child: InkWell(
//         onTap: (() {
//           Navigator.pop(context);
//           setState(() {
//             if (id == 1) {
//               currentpage = DrawerSections.isidashboard;
//             } else if (id == 2) {
//               currentpage = DrawerSections.mesin1;
//             } else if (id == 3) {
//               currentpage = DrawerSections.mesin2;
//             } else if (id == 4) {
//               currentpage = DrawerSections.mesin3;
//             } else if (id == 5) {
//               currentpage = DrawerSections.mesin4;
//             } else if (id == 6) {
//               currentpage = DrawerSections.setting;
//             } else if (id == 7) {
//               currentpage = DrawerSections.kelolaakun;
//             } else if (id == 8) {
//               currentpage = DrawerSections.logout;
//             }
//             print(currentpage);
//           });
//         }),
//         child: Padding(
//           padding: EdgeInsets.all(15),
//           child: Row(
//             children: [
//               Container(
//                 padding: EdgeInsets.only(left: 15),
//                 child: Icon(
//                   icon,
//                   size: 20,
//                   color: Colors.black,
//                 ),
//               ),
//               Container(
//                   padding: EdgeInsets.only(left: 30),
//                   child: Text(
//                     title,
//                     style: TextStyle(color: Colors.black, fontSize: 20),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// enum DrawerSections {
//   isidashboard,
//   mesin1,
//   mesin2,
//   mesin3,
//   mesin4,
//   setting,
//   kelolaakun,
//   logout,
// }


//content stock bahan dashboard
// return Material(
//       child: Container(
//         padding: EdgeInsets.only(bottom: 0),
//         height: 200,
//         width: 200,
//         decoration: BoxDecoration(color: Colors.grey[300], boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.9),
//               offset: Offset(2, 2),
//               blurRadius: 5)
//         ]),
//         child: InkWell(
//           splashColor: Colors.black,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 size: 40,
//               ),
//               Text(
//                 title,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//               ),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [Text(A), Text(B), Text(C)],
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text(
//                     "20",
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   Text("30", style: TextStyle(fontSize: 20)),
//                   Text("40", style: TextStyle(fontSize: 20)),
//                 ],
//               )
//             ],
//           ),
//           onTap: () {
//           },
//         ),
//       ),
//     );

// Testing Database
// child: FutureBuilder(
//                 future: MongoDatabase.getData(),
//                 builder: (context, AsyncSnapshot snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else {
//                     if (snapshot.hasData) {
//                       var totalData = snapshot.data.length;
//                       print(totalData);
//                       return Container(
//                         padding: EdgeInsets.all(20),
//                         child: Text("DATA FOUND", style: TextStyle(fontSize: 24),)
//                       );
//                     } else {
//                       return Center(
//                         child: Text("No Data Available"),
//                       );
//                     }
//                   }
//                 },
//               ),

//GET USER----------------------------------------------------------
// Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     height: 200,
//                     width: MediaQuery.of(context).size.width,
//                     color: Colors.grey,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           (dataResponseGet == null)
//                               ? "No data"
//                               : "Username : ${dataResponseGet.username}",
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         Text(
//                           (dataResponseGet == null)
//                               ? "No data"
//                               : "Password : ${dataResponseGet.password}",
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         Text(
//                           (dataResponseGet == null)
//                               ? "No data"
//                               : "email : ${dataResponseGet.email}",
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         Text(
//                           (dataResponseGet == null)
//                               ? "No data"
//                               : "otoritas : ${dataResponseGet.otoritas}",
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         Text(
//                           (dataResponseGet == null)
//                               ? "No data"
//                               : "noHp : ${dataResponseGet.noHp}",
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             HttpUserGet.connectAPIGet(
//                                     "63da14cdd34ce00bc0826bc7")
//                                 .then((value) {
//                               setState(() {
//                                 dataResponseGet = value;
//                               });
//                             });
//                           },
//                           child: Text(
//                             "Get User",
//                             style: TextStyle(color: Colors.amber),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//Tombol Delete-------------------------------------------------
// ElevatedButton(
//                           onPressed: () async {
//                             // ignore: use_build_context_synchronously
//                             showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     title: Text("Hapus Data"),
//                                     content: Text("Yakin DECK????"),
//                                     actions: [
//                                       ElevatedButton(
//                                         onPressed: () async {
//                                           var responseDelete =
//                                               await http.delete(Uri.parse(
//                                                   "http://192.168.1.13:5000/api/users/63dcbd1b483803b5c1c8ecdc"));
//                                           print(responseDelete.statusCode);
//                                           Navigator.of(context).pop(true);
//                                           if (responseDelete.statusCode ==
//                                               200) {
//                                             showDialog(
//                                                 context: context,
//                                                 builder: (context) {
//                                                   return AlertDialog(
//                                                     title: Text(
//                                                         "Data Berhasil Dihapus"),
//                                                     content: Text(
//                                                         "Datanya udah di hapus"),
//                                                     actions: [
//                                                       ElevatedButton(
//                                                         onPressed: () {
//                                                           Navigator.of(context)
//                                                               .pop();
//                                                         },
//                                                         child: Text("Close"),
//                                                       ),
//                                                     ],
//                                                   );
//                                                 });
//                                             setState(() {
//                                               tes = "berhasil dihapus";
//                                             });
//                                           } else {
//                                             tes = "gagal dihapus";
//                                           }
//                                         },
//                                         child: Text("YES"),
//                                       ),
//                                       ElevatedButton(
//                                         onPressed: () async {
//                                           Navigator.of(context).pop(true);
//                                         },
//                                         child: Text("NO"),
//                                       ),
//                                     ],
//                                   );
//                                 });
//                           },
//                           child: Text("Delete Data"),
//                         ),

// tombol update
// ElevatedButton(
//                           onPressed: () {
//                             HttpUserPut.connectAPIPut(
//                                 "63dcad3e483803b5c1c8ecba",
//                                 name.text,
//                                 pass.text,
//                                 emailAddress.text,
//                                 oto.text,
//                                 nohp.text);
//                           },
//                           child: Text("Update Data"),
//                         ),

// child: DropdownButton<String>(
                            //     hint: Text("Pilih Otoritas"),
                            //     value: dropDownValue,
                            //     items: otoritas
                            //         .map<DropdownMenuItem<String>>((String e) {
                            //       return DropdownMenuItem<String>(
                            //           value: e, child: Text(e));
                            //     }).toList(),
                            //     onChanged: (value) {
                            //       setState(() {
                            //         dropDownValue = value!;
                            //       });
                            //       print(value);
                            //     }),

// showDialog(
                                                    //     context: context,
                                                    //     builder: (context) {
                                                    //       return AlertDialog(
                                                    //         title: Text(
                                                    //             "Yakin Mau Menghapus User Ini?"),
                                                    //         content: Text(
                                                    //             "${e.username}"),
                                                    //         actions: [
                                                    //           OutlinedButton(
                                                    //               onPressed:
                                                    //                   () {
                                                    //                 Navigator.of(
                                                    //                         context)
                                                    //                     .pop();
                                                    //               },
                                                    //               child: Text(
                                                    //                   "Tidak")),
                                                    //           OutlinedButton(
                                                    //               onPressed:
                                                    //                   () {
                                                    // HttpUserDelete.connectAPIDelete("${e.id}").then((value) => Navigator.pushNamed(
                                                    //     context,
                                                    //     myakun,
                                                    //     arguments:
                                                    //         "berhasil hapus"));
                                                    //                 print(e.id);
                                                    //               },
                                                    //               child: Text(
                                                    //                   "Ya"))
                                                    //         ],
                                                    //       );
                                                    //     });

  // MODEL LIST MENU DRAWER MESIN 1--------------------------------------------------------------------------------------------------------
  // Widget ListDrawer1(BuildContext contextdrawer, String titledrawer,
  //     String navdrawer, String argdrawer, IconData icondrawer) {
  //   // UNTUK LEBAR TAMPILAN
  //   final MediaQuerywidth = MediaQuery.of(contextdrawer).size.width;
  //   double blockHorizontal = MediaQuerywidth / 100;

  //   // UNTUK TINGGI TAMPILAN
  //   final MediaQueryheight = MediaQuery.of(contextdrawer).size.height;
  //   double blockVertical = MediaQueryheight / 100;

  //   return ListTile(
  //     contentPadding: EdgeInsets.only(
  //         left: blockHorizontal * 15, bottom: blockVertical * 0.01),
  //     leading: Icon(
  //       icondrawer,
  //       color: Colors.black,
  //       size: blockVertical * 3,
  //     ),
  //     title: Text(
  //       titledrawer,
  //       style: TextStyle(fontSize: blockVertical * 2.5),
  //     ),
  //     onTap: () {
  //       Navigator.pushNamed(contextdrawer, navdrawer, arguments: argdrawer);
  //       setState(() {
  //         id = 1;
  //         print(id);
  //       });
  //     },
  //   );
  // }