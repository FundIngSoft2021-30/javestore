//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/Pages/Catalogo/categorias.dart';
import 'package:http/http.dart' as http;
import 'package:jave_store/Pages/Catalogo/pages/screenLibro.dart';

class Catalogo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [Categories(), ScreenLibro()],
    );
  }
}
