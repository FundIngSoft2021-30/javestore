//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Oferta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
      child: Container(
      child: Center(child: Text("OFERTA"),),
      ),
    );
  }
}