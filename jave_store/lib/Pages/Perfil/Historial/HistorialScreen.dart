//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jave_store/Entidades/Pedido.dart';
import 'package:jave_store/Entidades/Producto.dart';
import 'package:jave_store/Pages/Perfil/Historial/VerPedido.dart';
import 'package:jave_store/controller/Cart/cartController.dart';
import 'package:jave_store/controller/Pedido/pedidoController.dart';
import 'package:jave_store/controller/apiFB.dart';
import 'package:intl/intl.dart';

class HistorialScreen extends StatelessWidget {
  final ApiFB ap = new ApiFB();
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
                    return FutureBuilder<Producto>(
                        future:
                            ap.get_product(snapshot.data[index].productos[0]),
                        builder: (context, AsyncSnapshot<Producto> snap) {
                          return snap.hasData
                              ? Card(
                                  child: ListTile(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => VerPedido(
                                              date: DateFormat('dd-MM-yyyy')
                                                  .format(snapshot
                                                      .data[index].fecha
                                                      .toDate()),
                                              cost: snapshot.data[index].total,
                                              productos: snapshot
                                                  .data[index].productos));
                                    },
                                    leading: Image.network(
                                      snap.data.image,
                                      fit: BoxFit.cover,
                                      height: 80,
                                      width: 80,
                                    ),
                                    title: Text(
                                        '${DateFormat('dd-MM-yyyy').format(snapshot.data[index].fecha.toDate())}'),
                                    subtitle: Text(
                                        '${snapshot.data[index].productos}'),
                                  ),
                                )
                              : Container();
                        });
                  })
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
