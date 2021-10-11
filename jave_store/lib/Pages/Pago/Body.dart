//@dart=2.9
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Widgets/ButtonOption.dart';
import 'package:jave_store/Pages/Widgets/LabelText.dart';
import 'package:jave_store/Pages/Widgets/Button.dart';

class body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
  final String total;

  body({Key key, this.total}) : super(key: key);
}

class _BodyState extends State<body> {
  String passCamp = "";
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Método de pago',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: size.height / 20),
            ButtonOption(),
            SizedBox(height: size.height / 10),
            Text(
              'Indicaciones:',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: size.height / 20),
            LabelText(),
            SizedBox(height: size.height / 10),
            Text(
              'Total:           \$' + widget.total.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(height: size.height / 20),
            Button(textoBoton: "Pagar", divHeight: 15, divWidth: 2),
          ]),
    );
  }
}
