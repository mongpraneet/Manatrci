import 'package:flutter/material.dart';
import 'package:ohrci/page/regeister.dart';
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MyStyle().showLogo(),
              MyStyle().showTextH1('manat mongpraneet'),
              userForm(),
              passwordForm(),
              loginButton(),
              regitsterButton(),
            ],
          ),
        ),
      ),
    );
  }

  Container loginButton() {
    return Container(
      width: 250,
      child: RaisedButton(
        onPressed: () {},
        child: Text('Login'),
        color: Colors.red,
        textColor: Colors.white,
      ),
    );
  }

  Container regitsterButton() {
    return Container(
      width: 250,
      child: FlatButton(
          onPressed: () {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => Register(),
            );Navigator.push(context, route);
          },
          child: Text(
            'New Register',
            style: TextStyle(color: Colors.pink),
          )),
    );
  }

  Widget userForm() => Container(
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          decoration: MyStyle().myInputDecoration('User :'),
        ),
        width: 250,
      );

  Widget passwordForm() => Container(
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          decoration: MyStyle().myInputDecoration('Password :'),
        ),
        width: 250,
      );
}
