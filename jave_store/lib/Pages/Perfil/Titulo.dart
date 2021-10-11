import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Titulo extends StatelessWidget {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: <Widget>[
      Row(children: <Widget>[
        Container(color: Colors.blue, height: 50.0, width: size.width)
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Text(
          'Perfil',
          style: TextStyle(fontSize: 32, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 50.0),
      ])
    ]);
  }
}
