import 'package:flutter/material.dart';
import 'package:ohrci/widget/show_info_shop.dart';
import 'package:ohrci/widget/show_my_order_shop.dart';
import 'package:ohrci/widget/show_my_product.dart';

class MainShhop extends StatefulWidget {
  @override
  _MainShhopState createState() => _MainShhopState();
}

class _MainShhopState extends State<MainShhop> {
  Widget currentWidget = ShowMyOrdrShop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDraw(),
      appBar: AppBar(
        title: Text('Welcom shop123'),
      ),
      body: currentWidget,
    );
  }

  Drawer showDraw() {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(accountName: null, accountEmail: null),
          menuMyOuder(),
          menuMyProduct(),
          menuMyInformation(),
        ],
      ),
    );
  }

  ListTile menuMyOuder() => ListTile(
        leading: Icon(Icons.looks_one),
        title: Text('Show My Order'),
        subtitle: Text('ดูรายการสั่งสินค้า'),
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentWidget = ShowMyOrdrShop();
          });
        },
      );

  ListTile menuMyProduct() => ListTile(
        leading: Icon(Icons.looks_one),
        title: Text('Show Product'),
        subtitle: Text('สินค้า'),
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentWidget = ShowMyProduct();
          });
        },
      );

  ListTile menuMyInformation() => ListTile(
        leading: Icon(Icons.looks_one),
        title: Text('Show Informate'),
        subtitle: Text('รายละเอียด'),
        onTap: () {
          Navigator.pop(context);
          setState(() {
            currentWidget = ShowInfoShop();
          });
        },
      );
}
