//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Pedido.dart';
import 'package:jave_store/Pages/Perfil/Historial/VerPedido.dart';
import 'package:jave_store/controller/Cart/cartController.dart';
import 'package:jave_store/controller/Pedido/pedidoController.dart';
import 'package:jave_store/controller/apiFB.dart';
import 'package:intl/intl.dart';

class HistorialScreen extends StatelessWidget {
  // final url = "http://10.0.2.2/jave/queryDB.php";
  // Future getData() async {
  //   final response = await http.post(Uri.parse(url), body: {
  //     "query":
  //        "select sum(total_producto) from (select c.carritoID as idcar,p.nombre as producto,SUM(c.cantidad)*c.precio as total_producto,SUM(c.cantidad) cantidad, i.porcentaje as impuestos from Carrito_Productos c, Producto p,Carrito_Impuesto ci,Impuesto i,Carrito as ca where c.id_producto =p.id and i.id=ci.Impuestoid and ci.Carritoid=ca.id and ca.estado='1' group by c.carritoID,c.id_producto,i.id) as Cart;"
  //   });
  ApiFB ap = new ApiFB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historial de Compra"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Pedido>>(
        future: pedidoController(ap.firestore)
            .get_pedido(CartController().getCardId()),
        builder: (context, AsyncSnapshot<List<Pedido>> snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: Image(
                              image: NetworkImage(
                                  "https://image.flaticon.com/icons/png/512/107/107831.png"),
                            ),
                            title: Text(
                                '${DateFormat('dd-MM-yyyy').format(snapshot.data[index].fecha.toDate())}'),
                            subtitle:
                                Text(snapshot.data[index].productos.toString()),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text('Ver pedido'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VerPedido(
                                              productos: snapshot
                                                  .data[index].productos,
                                            )),
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ],
                      ),
                    );
                  })
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
