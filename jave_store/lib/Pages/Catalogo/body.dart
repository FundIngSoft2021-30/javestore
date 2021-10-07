import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Catalogo/Background.dart';
import 'package:jave_store/Pages/Componentes/AppBarBottom.dart';
import 'package:jave_store/Pages/Componentes/SearchBar.dart';

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
      appBar: SearchBar(),
      bottomNavigationBar: AppBarBottom(),
    );
  }
}
