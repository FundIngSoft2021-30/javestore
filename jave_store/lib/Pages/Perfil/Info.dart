//@dart=2.9
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  final String numero;
  final String name;
  Info({this.name, this.numero});
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 20,
      width: size.width/1.5,
      child: Row(
        children: [
          Text("${this.name}:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
          Spacer(),
          Text(
            numero,
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }
}
