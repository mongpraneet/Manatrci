import 'package:flutter/material.dart';
import 'package:ohrci/models/user_model.dart';
import 'package:ohrci/page/main_shop.dart';
import 'package:ohrci/page/main_user.dart';
import 'package:ohrci/page/regeister.dart';
import 'package:ohrci/utlilty/my_api.dart';
import 'package:ohrci/utlilty/my_style.dart';
import 'package:ohrci/utlilty/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String user, password;

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
        onPressed: () {
          if (user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty) {
            normalDioalg(context, 'กรุณากรอก ทุกช่อง');
          } else {
            checkAuthen();
          }
        },
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
            );
            Navigator.push(context, route);
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
          onChanged: (valuse) => user = valuse.trim(),
          decoration: MyStyle().myInputDecoration('User :'),
        ),
        width: 250,
      );

  Widget passwordForm() => Container(
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          onChanged: (values) => password = values.trim(),
          decoration: MyStyle().myInputDecoration('Password :'),
        ),
        width: 250,
      );

  Future<Null> checkAuthen() async {
    UserModel model = await MyAPI().getUserWhereUser(user);
    if (model == null) {
      normalDioalg(context, 'ไม่มี $user คนนี้ในฐานข้อมูล');
    } else {
      if (password == model.password) {
        print(model.type.toString());
        switch (model.type.toString()) {
          case 'User':
            routeTo(MainUser(), model);
            break;
          case 'Shop':
            routeTo(MainShhop(), model);
            break;
          default:
        }
      } else {
        normalDioalg(context, 'Password False');
      }
    }
  }

  Future<Null> routeTo(Widget widget, UserModel model) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', model.id);
    preferences.setString('Name', model.name);
    preferences.setString('Type', model.type);


    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => widget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }
}
