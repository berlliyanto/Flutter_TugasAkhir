import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Headerdrawer extends StatefulWidget {
  const Headerdrawer({super.key});

  @override
  State<Headerdrawer> createState() => _HeaderdrawerState();
}

class _HeaderdrawerState extends State<Headerdrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 50),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 3, 131, 167),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(-1, 2),
            blurRadius: 2,
          )
        ],
        image: DecorationImage(image: AssetImage("images/asset1.png"),fit: BoxFit.cover),
      ),
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            backgroundColor: Colors.black.withOpacity(0.5),
            radius: 30,
            child: Icon(
              Icons.person,
              size: 50,
              color: Colors.white,
              shadows: [
                Shadow(
                    color: Colors.black, offset: Offset(2, 2), blurRadius: 10)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome Nama...",
              style: GoogleFonts.getFont('Roboto',
                  color: Colors.white, fontSize: 14),
            ),
            Icon(
              Icons.emoji_emotions,
              color: Colors.white,
            ),
          ],
        ),
        Text(
          "Admin/User",
          style: TextStyle(color: Colors.white, fontSize: 10),
        ),
      ]),
    );
  }
}
