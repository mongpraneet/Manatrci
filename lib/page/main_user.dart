import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ohrci/models/user_model.dart';
import 'package:ohrci/page/show_menu_shop.dart';
import 'package:ohrci/utility/my_constant.dart';
import 'package:ohrci/utility/my_style.dart';

class MainUser extends StatefulWidget {
  @override
  _MainUserState createState() => _MainUserState();
}

class _MainUserState extends State<MainUser> {
  List<UserModel> userModes = List();
  List<Widget> widgest = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readShop();
  }

  Future<Null> readShop() async {
    String url =
        '${MyConstant().domain}/RCI/getUserWhereType.php?isAdd=true&Type=Shop';

    Response response = await Dio().get(url);
    //print('res = $response');
    var result = json.decode(response.data);

    //print('result = $result');
    int index = 0;

    for (var map in result) {
      UserModel model = UserModel.fromJson(map);
      if (!(model.createDate.isEmpty)) {
        // print('name = ${model.name}');
        setState(() {
          userModes.add(model);
          widgest.add(creagewidget(model.name, index));
        });
        index++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: MyStyle().menuSignOut(context),
      ),
      appBar: AppBar(
        title: Text('Welcome User'),
      ),
      body: userModes.length == 0 ? MyStyle().showProgress() : bulidShop(),
    );
  }

  Widget bulidShop() => GridView.extent(
        maxCrossAxisExtent: 160,
        children: widgest,
      );

  Widget creagewidget(String name, int index) {
    return GestureDetector(
      onTap: () {
        print('You Click Index = $index');
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => ShowMenuShop(
            userModel: userModes[index],
          ),
        );
        Navigator.push(context, route);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              child: Image.asset('images/shop.png'),
            ),
            Text(name)
          ],
        ),
      ),
    );
  }
}
