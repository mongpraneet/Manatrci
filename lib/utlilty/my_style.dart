import 'package:flutter/material.dart';




class MyStyle {

Color mainColor = Colors.pink;
Color darkColor = Colors.blue.shade800;
Color redColor =  Colors.red.shade500;


  Text showTextH1(String string) => Text(
        string,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: redColor,
        ),
      );

  Container showLogo() {
    return Container(
      width: 150,
      child: Image.asset('images/logo.png'),
    );
  }

  MyStyle();
}
