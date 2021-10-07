import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Catalogo/Body.dart';

class background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
      child: body(),
    );
  }
}
