import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InfoCelular extends StatelessWidget {
  String numero = '3117532311';
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Celular', style: TextStyle(fontSize: 18)),
      Padding(
        padding: EdgeInsets.all(5),
        child: Stack(children: <Widget>[
          Container(
            color: Colors.grey,
            height: 43,
            width: 306,
          ),
          Text(numero, style: TextStyle(fontSize: 18))
        ]),
      )
    ]);
  }
}
