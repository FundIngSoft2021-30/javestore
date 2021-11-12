//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Catalogo/ventanaProducto.dart';

class body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<body> {
  String passCamp = "";
  @override
  Widget build(BuildContext context) {
    return Container(child: ventanaProducto());
  }
}
