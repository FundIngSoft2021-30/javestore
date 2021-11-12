//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/ProductoDetallado/Background.dart';

void main() => runApp(productoDetallado());

class productoDetallado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        //  appBar: AppBar(),
        body: background(),
      ),
    );
  }
}
