import 'package:flutter/material.dart';

class MainShhop extends StatefulWidget {
  @override
  _MainShhopState createState() => _MainShhopState();
}

class _MainShhopState extends State<MainShhop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDraw(),
      appBar: AppBar(
        title: Text('Welcom shop'),
      ),
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
        },
      );

       ListTile menuMyProduct() => ListTile(
        leading: Icon(Icons.looks_one),
        title: Text('Show My Order'),
        subtitle: Text('สินค้า'),
        onTap: () {
          Navigator.pop(context);
        },
      );

       ListTile menuMyInformation() => ListTile(
        leading: Icon(Icons.looks_one),
        title: Text('Show My Order'),
        subtitle: Text('รายละเอียด'),
        onTap: () {
          Navigator.pop(context);
        },
      );
}
