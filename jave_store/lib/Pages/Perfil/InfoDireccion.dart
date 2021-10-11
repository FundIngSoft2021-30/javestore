import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InfoDireccion extends StatelessWidget {
  String direccion = 'Avenida 60 apt 45';
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Direccion', style: TextStyle(fontSize: 18)),
      Padding(
        padding: EdgeInsets.all(5),
        child: Stack(children: <Widget>[
          Container(
            color: Colors.grey,
            height: 43,
            width: 306,
          ),
          Text(direccion, style: TextStyle(fontSize: 18))
        ]),
      ),
    ]);
  }
}
