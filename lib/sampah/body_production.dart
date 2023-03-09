// // ignore_for_file: unused_local_variable, prefer_adjacent_string_concatenation

// import 'dart:async';
// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:list_wheel_scroll_view_nls/list_wheel_scroll_view_nls.dart';

// class bodyProduction extends StatefulWidget {
//   const bodyProduction({super.key});

//   @override
//   State<bodyProduction> createState() => _bodyProductionState();
// }

// class _bodyProductionState extends State<bodyProduction> {
//   @override
//   Widget build(BuildContext context) {
//     // UNTUK LEBAR TAMPILAN
//     final MediaQuerywidth = MediaQuery.of(context).size.width;
//     double blockHorizontal = MediaQuerywidth / 100;

//     // UNTUK TINGGI TAMPILAN
//     final MediaQueryheight = MediaQuery.of(context).size.height;
//     double blockVertical = MediaQueryheight / 100;
//     final myappbar = AppBar(
//       title: Text("Media Query"),
//     );
//     final bodyheight = MediaQueryheight -
//         myappbar.preferredSize.height -
//         MediaQuery.of(context).padding.top;

//     // Mengetahui Orientasi Device
//     final bool isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;

//     return Padding(
//       padding: EdgeInsets.fromLTRB(
//           blockHorizontal * 1.8, blockVertical * 3, blockHorizontal * 1.8, 0),
//       child: ClipRRect(
//         clipBehavior: Clip.antiAlias,
//         borderRadius: BorderRadius.circular(blockVertical * 3),
//         child: Container(
//           height: blockVertical * 46,
//           width: blockHorizontal * 93,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 begin: Alignment.bottomCenter,
//                 end: Alignment.topCenter,
//                 colors: [
//                   Color(0xFF3ac3cb),
//                   Color(0xFFFFFFFF),
//                 ]),
//           ),
//           child: ListWheelScrollViewX(
//             itemExtent: blockHorizontal * 90,
//             physics: FixedExtentScrollPhysics(),
//             scrollDirection: Axis.horizontal,
//             children: [
//               contentproduction(
//                 (context),
//                 "Production Monitoring",
//                 "Mesin 1",
//                 Icons.computer,
//               ),
//               // SizedBox(
//               //   width: 10,
//               // ),
//               contentproduction(
//                 (context),
//                 "Production Monitoring",
//                 "Mesin 2",
//                 Icons.computer,
//               ),
//               // SizedBox(
//               //   width: 10,
//               // ),
//               contentproduction(
//                 (context),
//                 "Production Monitoring",
//                 "Mesin 3",
//                 Icons.computer,
//               ),
//               // SizedBox(
//               //   width: 10,
//               // ),
//               contentproduction(
//                 (context),
//                 "Production Monitoring",
//                 "Mesin 4",
//                 Icons.computer,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // CONTENT PRODUCTION MONITORING----------------------------------------------------------------------------------------------------------------
//   Widget contentproduction(
//     BuildContext context,
//     String production,
//     String title,
//     IconData icon,
//   ) {
//     // UNTUK LEBAR TAMPILAN
//     final MediaQuerywidth = MediaQuery.of(context).size.width;
//     double blockHorizontal = MediaQuerywidth / 100;

//     // UNTUK TINGGI TAMPILAN
//     final MediaQueryheight = MediaQuery.of(context).size.height;
//     double blockVertical = MediaQueryheight / 100;
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(blockVertical * 3),
//       child: Container(
//         margin: EdgeInsets.fromLTRB(blockHorizontal * 0.1, blockVertical * 0.01,
//             blockHorizontal * 0.1, blockVertical * 0.01),
//         width: blockHorizontal * 85,
//         height: blockVertical * 87 / 2,
//         color: Colors.transparent,
//         child: Stack(children: [
//           //blurEffect
//           BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
//             child: Container(),
//           ),
//           Container(
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(blockVertical * 3),
//                 border: Border.all(
//                   color: Colors.white.withOpacity(0.13),
//                 ),
//                 gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       Colors.black.withOpacity(0.15),
//                       Colors.black.withOpacity(0.5)
//                     ])),
//             child: Container(
//               margin: EdgeInsets.all(5),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 //HEADER----------------------------------------------------------------------------------------------------------------
//                 children: [
//                   Icon(
//                     icon,
//                     size: blockVertical * 5.5,
//                     color: Colors.white,
//                   ),
//                   Text(
//                     production,
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: blockVertical * 2.7,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     title,
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: blockVertical * 2.5,
//                         color: Colors.white),
//                   ),
//                   SizedBox(height: blockVertical * 1.5),
//                   Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Text(
//                           "Status :  " + "Running",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: blockVertical * 1.7,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           "Type :  " + "A",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: blockVertical * 1.7,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ]),
//                   SizedBox(
//                     height: blockVertical * 1.7,
//                   ),
//                   //PRODUCTION----------------------------------------------------------------------------------------------------------------
//                   Container(
//                     padding: EdgeInsets.only(
//                         left: blockHorizontal * 5, top: blockVertical * 0.1),
//                     decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topRight,
//                           end: Alignment.bottomLeft,
//                           colors: [
//                             Color.fromARGB(255, 65, 99, 127).withOpacity(0.5),
//                             Color.fromARGB(255, 9, 130, 141).withOpacity(0.2),
//                           ],
//                         ),
//                         borderRadius: BorderRadius.circular(20)),
//                     child: Column(
//                       children: [
//                         Text(
//                           "Production",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: blockVertical * 2.5,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(
//                           height: blockVertical * 0.8,
//                         ),
//                         Row(
//                           children: [
//                             Text("Processed Unit : ",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: blockVertical * 1.8,
//                                     fontWeight: FontWeight.bold)),
//                           ],
//                         ),
//                         SizedBox(
//                           height: blockVertical * 0.8,
//                         ),
//                         Row(
//                           children: [
//                             Text("Flawless Unit : ",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: blockVertical * 1.8,
//                                     fontWeight: FontWeight.bold)),
//                           ],
//                         ),
//                         SizedBox(
//                           height: blockVertical * 0.8,
//                         ),
//                         Row(
//                           children: [
//                             Text("Defect Unit : ",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: blockVertical * 1.8,
//                                     fontWeight: FontWeight.bold)),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: blockVertical * 0.8),
//                   //PRODUCTION TIME----------------------------------------------------------------------------------------------------------------
//                   Container(
//                     padding: EdgeInsets.only(
//                         left: blockHorizontal * 5, top: blockVertical * 0.1),
//                     decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topRight,
//                           end: Alignment.bottomLeft,
//                           colors: [
//                             Color.fromARGB(255, 9, 130, 141).withOpacity(0.5),
//                             Color.fromARGB(255, 65, 99, 127).withOpacity(0.2),
//                           ],
//                         ),
//                         borderRadius: BorderRadius.circular(20)),
//                     child: Column(
//                       children: [
//                         Text(
//                           "Production Time",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: blockVertical * 2.5,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(
//                           height: blockVertical * 0.8,
//                         ),
//                         Row(
//                           children: [
//                             Text("Running Time : ",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: blockVertical * 1.8,
//                                     fontWeight: FontWeight.bold)),
//                           ],
//                         ),
//                         SizedBox(
//                           height: blockVertical * 0.8,
//                         ),
//                         Row(
//                           children: [
//                             Text("Operation Time : ",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: blockVertical * 1.8,
//                                     fontWeight: FontWeight.bold)),
//                           ],
//                         ),
//                         SizedBox(
//                           height: blockVertical * 0.8,
//                         ),
//                         Row(
//                           children: [
//                             Text("DownTime : ",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: blockVertical * 1.8,
//                                     fontWeight: FontWeight.bold)),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }
