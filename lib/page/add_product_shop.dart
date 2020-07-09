import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohrci/utility/my_style.dart';

class AddProductShope extends StatefulWidget {
  @override
  _AddProductShopeState createState() => _AddProductShopeState();
}

class _AddProductShopeState extends State<AddProductShope> {
  File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            imageGroup(),
            nameForm(),
            prictForm(),
            detailForm(),
          ],
        ),
      ),
    );
  }

  Widget nameForm() => Container(
        width: 250,
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          decoration: MyStyle().myInputDecoration('Name Product'),
        ),
      );

  Widget prictForm() => Container(
        width: 250,
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          decoration: MyStyle().myInputDecoration('Prict Product'),
        ),
      );

  Widget detailForm() => Container(
        width: 250,
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          decoration: MyStyle().myInputDecoration('Detail Product'),
        ),
      );

  Future<Null> chooseSource(ImageSource source) async {
    try {
      var object = await ImagePicker().getImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
      );

      setState(() {
        file = File(object.path);
      });
    } catch (e) {}
  }

  Widget imageGroup() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: () => chooseSource(ImageSource.camera),
          ),
          Container(
            padding: EdgeInsets.all(16),
            width: 250,
            height: 250,
            child:
                file == null ? Image.asset('images/pic.png') : Image.file(file),
          ),
          IconButton(
            icon: Icon(Icons.add_photo_alternate),
            onPressed: () => chooseSource(ImageSource.gallery),
          )
        ],
      );
}
