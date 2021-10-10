import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Perfil/Titulo.dart';

class InformacionPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Titulo(),
        Container(color: Colors.pink, height: 100, width: 100),
      ],
    ));
  }
}
