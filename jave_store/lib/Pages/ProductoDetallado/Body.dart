//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/ProductoDetallado/ProductoDetallado.dart';
import 'package:jave_store/Pages/Widgets/AppBarBottom.dart';
import 'package:jave_store/Pages/Widgets/SearchBar.dart';
import 'package:jave_store/Pages/Widgets/GridViewProductos.dart';

class body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<body> {
  bool _pass = false;
  String passCamp = "";
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: productoDetallado(),
    );
  }
}
