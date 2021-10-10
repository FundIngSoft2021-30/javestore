// @dart=2.9
import 'dart:async';
import 'package:http/http.dart' as http;

void main() {
  var url = "http://10.0.2.2/jave/queryDB.php";
  Future<List> getData() async {
    final response = await http.post(Uri.parse(url), body: {
      "query":
          "select sum(total_producto) from (select c.carritoID as idcar,p.nombre as producto,SUM(c.cantidad)*c.precio as total_producto,SUM(c.cantidad) cantidad, i.porcentaje as impuestos from Carrito_Productos c, Producto p,Carrito_Impuesto ci,Impuesto i,Carrito as ca where c.id_producto =p.id and i.id=ci.Impuestoid and ci.Carritoid=ca.id group by c.carritoID,c.id_producto,i.id) as Cart;"
    });
    print(response.body);
  }

  getData();
}
