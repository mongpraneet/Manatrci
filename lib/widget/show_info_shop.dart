import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ohrci/models/user_model.dart';
import 'package:ohrci/page/add_info_shop.dart';
import 'package:ohrci/page/edit_info_shoup.dart';
import 'package:ohrci/utility/my_constant.dart';
import 'package:ohrci/utility/my_style.dart';

class ShowInfoShop extends StatefulWidget {
  final String idShop;
  ShowInfoShop({Key key, this.idShop});

  @override
  _ShowInfoShopState createState() => _ShowInfoShopState();
}

class _ShowInfoShopState extends State<ShowInfoShop> {
  String idShop;
  bool ststus = true;
  bool ststus2 = true;
  UserModel userModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    idShop = widget.idShop;
    readInfo();
  }

  Future<Null> readInfo() async {
    String url =
        '${MyConstant().domain}/RCI/getUserWhereIdUng.php?isAdd=true&id=$idShop';
    Response response = await Dio().get(url);
    setState(() {
      ststus2 = false;
    });

    var result = json.decode(response.data);
    for (var map in result) {
      userModel = UserModel.fromJson(map);
      String dateTime = userModel.createDate;
      if (!(dateTime == null || dateTime.isEmpty)) {
        setState(() {
          ststus = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ststus ?  addButton(context) :  editButton(context),
      body: ststus2
          ? MyStyle().showProgress()
          : ststus
              ? Center(
                  child: MyStyle().showTextH1('ยังไม่มีข้อมูลร้านค้า'),
                )
              : showContent(),
    );
  }

  FloatingActionButton addButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => AddInfoShop(),
        );
        Navigator.push(context, route).then((value) => null);
      },
      child: Icon(Icons.add),
    );
  }

  FloatingActionButton editButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => EditInfoShop(userModel: userModel,),
        );
        Navigator.push(context, route).then((value) => null);
      },
      child: Icon(Icons.edit),
    );
  }

  Widget showContent() => Column(
        children: <Widget>[
          MyStyle().showTextH1('ข้อมูลร้าน ${userModel.name}'),
          MyStyle().showTextH2('บันทึกวันที่ ${userModel.createDate}'),
          showAddress(),
          showGendel(),
          showEducate(),
          showPhone(),
        ],
      );

  ListTile showAddress() {
    return ListTile(
      leading: Icon(
        Icons.home,
        size: 36,
        color: Colors.purple,
      ),
      title: MyStyle().showTextH2(userModel.address),
    );
  }

  ListTile showGendel() {
    return ListTile(
      leading: Icon(
        Icons.account_box,
        size: 36,
        color: Colors.orange,
      ),
      title: MyStyle().showTextH2(userModel.gendel),
    );
  }

  ListTile showEducate() {
    return ListTile(
      leading: Icon(
        Icons.label_important,
        size: 36,
        color: Colors.green,
      ),
      title: MyStyle().showTextH2(userModel.education),
    );
  }

 ListTile showPhone() {
    return ListTile(
      leading: Icon(
        Icons.phone_android,
        size: 36,
        color: Colors.blue,
      ),
      title: MyStyle().showTextH2(userModel.phone),
    );
  }

}
