//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Widgets/AppBarBottom.dart';
import 'package:jave_store/Pages/Widgets/AppBarTop.dart';
import 'package:jave_store/Pages/Widgets/ButtonOption.dart';
import 'package:jave_store/Pages/Widgets/LabelText.dart';
import 'package:jave_store/Pages/Widgets/Button.dart';

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
      appBar: AppBarTop(),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Método de pago',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
            ),
            SizedBox(height: 70),
            ButtonOption(),
            SizedBox(height: 70),
            Text(
              'Comentarios:',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
            ),
            SizedBox(height: 70),
            LabelText(),
            SizedBox(height: 70),
            Text(
              'Total: ',
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
            ),
            SizedBox(height: 10),
            Button(textoBoton: "Pagar"),
          ]),
      bottomNavigationBar: AppBarBottom(),
    );
  }
}
