import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Titulo extends StatelessWidget {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: <Widget>[
      Row(children: <Widget>[
        Container(color: Colors.blue, height: size.height, width: 50.0)
      ]),
      Row(children: <Widget>[Text('Perfil', style: TextStyle(fontSize: 32))])
    ]);
  }
}
