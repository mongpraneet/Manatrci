import 'package:flutter/material.dart';

Future<Null> normalDioalg(BuildContext context, String string) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(string),
      children: <Widget>[
        FlatButton(onPressed: () => Navigator.pop(context), child: Text('OK'))
      ],
    ),
  );
}
