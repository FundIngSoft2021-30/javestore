//@dart=2.9
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Perfil/Historial/HistorialScreen.dart';

class ButtonLoad extends StatefulWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  _ButtonLoad createState() => _ButtonLoad();
}

class _ButtonLoad extends State<ButtonLoad> {
  int _state = 0;

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text(
        "Confirmar Pedido",
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 16.0,
        ),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      );
    } else {
      return Icon(Icons.check, color: Colors.blue);
    }
  }

  void animateButton() {
    setState(() {
      _state = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        _state = 2;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HistorialScreen()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: setUpButtonChild(),
      onPressed: () {
        setState(() {
          if (_state == 0) {
            animateButton();
          }
          if (_state == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HistorialScreen()),
            );
          }
        });
      },
    );
  }
}
