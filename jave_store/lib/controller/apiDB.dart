// @dart=2.9
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:jave_store/Entidades/Categoria.dart';
import 'package:jave_store/Entidades/Producto.dart';

class ApiDB {
  //Methods
  Future<List<Categoria>> getCategory() async {
    final url = "https://javestore.000webhostapp.com/jave/queryDB.php";
    final response = await http.post(Uri.parse(url),
        body: {"query": "select * from Categoria order by id;"});
    List<Categoria> rt = CategoriaFromJson(response.body);
    return rt;
  }

  Future<List<String>> suggestions() async {
    final url = "https://javestore.000webhostapp.com/jave/queryDB.php";
    final response = await http
        .post(Uri.parse(url), body: {"query": "select nombre from Producto"});
    List<Producto> tmp = ProductoFromJson(response.body);
    List<String> rt = [];
    for (Producto x in tmp) rt.add(x.nombre);
    return rt;
  }

  Future<List<Producto>> getProduct(String val) async {
    final url = "https://javestore.000webhostapp.com/jave/queryDB.php";
    final response = await http.post(Uri.parse(url), body: {"query": val});
    List<Producto> rt = ProductoFromJson(response.body);
    return rt;
  }

  Future<bool> insertItem(String id_cart, String id_product) async {
    final url = "https://javestore.000webhostapp.com/jave/queryDB.php";
    final response = await http.post(Uri.parse(url), body: {
      "query":
          "insert into ItemsxCarrito (cantidad,Carritoid,Productoid) values (1,${id_cart},${id_product});"
    });
  }
}
