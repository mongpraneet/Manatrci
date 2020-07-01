import 'package:flutter/material.dart';
import 'package:ohrci/utlilty/my_style.dart';
import 'package:ohrci/utlilty/normal_dialog.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  List<String> types = ['User', 'Shoper'];
  String type, name, user, password;

  Widget userForm() => Container(
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          onChanged: (value) => user = value.trim(),
          decoration: MyStyle().myInputDecoration('User :'),
        ),
        width: 250,
      );

  Widget passwordForm() => Container(
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          onChanged: (value) => password = value.trim(),
          decoration: MyStyle().myInputDecoration('Password :'),
        ),
        width: 250,
      );

  Widget nameForm() => Container(
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          onChanged: (value) => name = value.trim(),
          decoration: MyStyle().myInputDecoration('Name :'),
        ),
        width: 250,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (name == null ||
              name.isEmpty ||
              user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty) {
            normalDioalg(context, 'Plases Fill Every Blank');
          } else if (type == null) {
            normalDioalg(context, 'โปรดเลือกชนิดของสมาชิก :(');
          } else {}
        },
        child: Icon(Icons.cloud_upload),
      ),
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              MyStyle().showLogo(),
              nameForm(),
              dropDownType(),
              userForm(),
              passwordForm(),
            ],
          ),
        ),
      ),
    );
  }

  Container dropDownType() => Container(
        child: DropdownButton(
          items: types
              .map(
                (e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ),
              )
              .toList(),
          hint: Text('Choost Type'),
          value: type,
          onChanged: (value) {
            setState(() {
              type = value;
            });
          },
        ),
      );
}
