import 'package:flutter/material.dart';
import 'package:ohrci/utlilty/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MyStyle().showLogo(),
            MyStyle().showTextH1('manat mongpraneet'),
            userForm()
          ],
        ),
      ),
    );
  }

  Widget userForm() => Container(
        child: TextField(),
        width: 250,
      );
}
