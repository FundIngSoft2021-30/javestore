//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HistorialScreen extends StatelessWidget {
  // final url = "http://10.0.2.2/jave/queryDB.php";
  // Future getData() async {
  //   final response = await http.post(Uri.parse(url), body: {
  //     "query":
  //        "select sum(total_producto) from (select c.carritoID as idcar,p.nombre as producto,SUM(c.cantidad)*c.precio as total_producto,SUM(c.cantidad) cantidad, i.porcentaje as impuestos from Carrito_Productos c, Producto p,Carrito_Impuesto ci,Impuesto i,Carrito as ca where c.id_producto =p.id and i.id=ci.Impuestoid and ci.Carritoid=ca.id and ca.estado='1' group by c.carritoID,c.id_producto,i.id) as Cart;"
  //   });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial de Compra"),
        centerTitle: true,
      ),
      body: ListView(children: [
        GestureDetector(
          onTap: () {
            print("herrera super mrk");
          },
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const ListTile(
                  leading: Image(
                    image: NetworkImage(
                        "https://panamericana.vteximg.com.br/arquivos/ids/180124-1080-1080/cien-anos-de-soledad-2-9789588886213.jpg?v=636209752836270000"),
                  ),
                  title: Text('Pedido el 9 Oct 2021'),
                  subtitle: Text('Cien años de Soledad...'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child: const Text('Ver pedido'),
                      onPressed: () {/* ... */},
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}