//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Pages/Catalogo/categorias.dart';
import 'package:jave_store/Pages/Catalogo/pages/screenLibro.dart';

void main() => runApp(Catalogo());

class Catalogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Categories(), ScreenLibro()],
    );
  }
}
