import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ohrci/utility/my_constant.dart';
import 'package:ohrci/utility/my_style.dart';
import 'package:ohrci/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductShope extends StatefulWidget {
  @override
  _AddProductShopeState createState() => _AddProductShopeState();
}

class _AddProductShopeState extends State<AddProductShope> {
  File file;
  String pathImage, name, price, detail, nameshop, idshop, code;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findShop();
  }

  Future<Null> findShop() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    idshop = preferences.getString('id');
    nameshop = preferences.getString('Name');
    print('idshop = $idshop, nameshop = $nameshop');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (file == null) {
            normalDialog(context, 'Please Choose Image');
          } else if (name == null ||
              name.isEmpty ||
              price.isEmpty ||
              detail.isEmpty) {
            normalDialog(context, 'Pless Fill Evre Bland');
          } else {
            uploadAadInsertProduct();
          }
        },
        child: Icon(Icons.cloud_upload),
      ),
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              imageGroup(),
              nameForm(),
              prictForm(),
              detailForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget nameForm() => Container(
        width: 250,
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          onChanged: (value) => name = value.trim(),
          decoration: MyStyle().myInputDecoration('Name Product'),
        ),
      );

  Widget prictForm() => Container(
        width: 250,
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) => price = value.trim(),
          decoration: MyStyle().myInputDecoration('Prict Product'),
        ),
      );

  Widget detailForm() => Container(
        width: 250,
        margin: EdgeInsets.only(top: 16),
        child: TextField(
          onChanged: (value) => detail = value.trim(),
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

  Future<Null> uploadAadInsertProduct() async {
    Random random = Random();
    int i = random.nextInt(100000);
    String nameFile = 'idShop${idshop}product$i.jpg';
    print('nameFile = $nameFile');
    code = 'idShop${idshop}code$i';
    print('code = $code');

    try {
      String urlUpload = '${MyConstant().domain}/RCI/saveFileUng.php';

      Map<String, dynamic> map = Map();
      map['file'] = await MultipartFile.fromFile(file.path, filename: nameFile);

      FormData formData = FormData.fromMap(map);
      await Dio().post(urlUpload, data: formData).then((value) async {
        pathImage = '/RCI/Product/$nameFile';
        print('upload sucess => pathaImage=${MyConstant().domain}$pathImage');

        String urlInsert =
            '${MyConstant().domain}/RCI/addProductUng.php?isAdd=true&IdShop=$idshop&NameShop=$nameshop&Name=$name&Price=$price&Detail=$detail&PathImage=$pathImage&Code=$code';
        await Dio().get(urlInsert).then((value) {
          if (value.toString() == 'true') {
            Navigator.pop(context);
          } else {
            normalDialog(context, 'Plesse Try Agins');
          }
        });
      });
    } catch (e) {}
  }
}
