import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<Null> normailToast(String string) async {
  Fluttertoast.showToast(
    msg: string,
    toastLength: Toast.LENGTH_LONG,
  );
}
