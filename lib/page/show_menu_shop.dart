import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ohrci/models/product_model.dart';
import 'package:ohrci/models/user_model.dart';
import 'package:ohrci/utility/my_constant.dart';
import 'package:ohrci/utility/my_style.dart';

class ShowMenuShop extends StatefulWidget {
  final UserModel userModel;
  ShowMenuShop({Key key, this.userModel}) : super(key: key);

  @override
  _ShowMenuShopState createState() => _ShowMenuShopState();
}

class _ShowMenuShopState extends State<ShowMenuShop> {
  UserModel userModel;
  bool status = true; //true => null Data
  Widget currentWidget = Center(
    child: Text('ยัวไม่มี เมนู'),
  );

  List<ProductModel> productModels = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userModel = widget.userModel;
    readMenuShop();
  }

  Future<Null> readMenuShop() async {
    String idShop = userModel.id;
    String url =
        '${MyConstant().domain}/RCI/getProductWhereIdShopUng.php?isAdd=true&IdShop=$idShop';
    await Dio().get(url).then((value) {
      setState(() {
        status = false;
      });

      if (value.toString() != 'null') {
        var result = json.decode(value.data);
        for (var map in result) {
          ProductModel model = ProductModel.fromJson(map);

          setState(() {
            productModels.add(model);
            currentWidget = showListMenu();
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(userModel.name),
        ),
        body: status ? MyStyle().showProgress() : currentWidget);
  }

  Widget showListMenu() {
    return ListView.builder(
      itemCount: productModels.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          showConfirm(index);
        },
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(
                          '${MyConstant().domain}${productModels[index].pathImage}'),
                      fit: BoxFit.cover)),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5 - 20,
              height: MediaQuery.of(context).size.width * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(productModels[index].name),
                  Text('ราคา ${productModels[index].price} บาท'),
                  Text(productModels[index].detail),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> showConfirm(int index) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(productModels[index].name),
        children: <Widget>[
          Container(
            width: 150,
            height: 120,
            child: Image.network(
                '${MyConstant().domain}${productModels[index].pathImage}'),
          ),
        ],
      ),
    );
  }
}
