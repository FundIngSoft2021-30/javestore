//@dart=2.9
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Widgets/AppBarBottom.dart';

void main() => runApp(Carrito());

class Carrito extends StatefulWidget {
  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Carro de compras",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        bottomNavigationBar: AppBarBottom(),
      ),
    );
  }
}
