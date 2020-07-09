import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ohrci/page/add_product_shop.dart';
import 'package:ohrci/utility/my_constant.dart';
import 'package:ohrci/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowMyProduct extends StatefulWidget {
  @override
  _ShowMyProductState createState() => _ShowMyProductState();
}

class _ShowMyProductState extends State<ShowMyProduct> {
  String idShop;
  bool waitStatus = true; //true ==> Load Data
  bool dateStatus = true; //true ==> no menu

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findShopAndMenu();
  }

  Future<Null> findShopAndMenu() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idShop = preferences.getString('id');

    //idShop = '1';

    String url =
        '${MyConstant().domain}/RCI/getProductWhereIdShopUng.php?isAdd=true&IdShop=$idShop';

    await Dio().get(url).then((value) {
      setState(() {
        waitStatus = false;
      });

      if (value.toString() != 'null') {
        setState(() {
          dateStatus = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => AddProductShope(),
          );
          Navigator.push(context, route).then((value) => null);
        },
        child: Icon(Icons.restaurant_menu),
      ),
      body: waitStatus
          ? MyStyle().showProgress()
          : dateStatus
              ? Center(child: MyStyle().showTextH1('กรุณา Add product'))
              : Text('Have Prodct'),
    );
  }
}
