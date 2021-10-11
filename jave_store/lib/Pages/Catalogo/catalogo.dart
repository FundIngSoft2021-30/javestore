//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Categoria.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/Pages/Catalogo/Item.dart';
import 'package:jave_store/Pages/Catalogo/categorias.dart';
import 'package:http/http.dart' as http;
import 'package:jave_store/Pages/Catalogo/pages/screenLibro.dart';

class Catalogo extends StatelessWidget {
  final url = "http://10.0.2.2/jave/queryDB.php";
  Future<List<Producto>> getData() async {
    final response = await http.post(Uri.parse(url), body: {
      "query":
          "select * from Producto p where p.Categoriaid=3 and p.estado='A';"
    });

    List<Producto> rt = ProductoFromJson(response.body);
    return rt;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Categories(),
        ScreenLibro()
      ],
    );
  }
}
