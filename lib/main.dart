import 'package:flutter/material.dart';
import 'package:ohrci/page/authen.dart';

main()=>runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Authen(),
    );
  }
}