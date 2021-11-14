// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jave_store/Entidades/Descuento.dart';
import 'package:jave_store/Entidades/Pedido.dart';
import 'package:jave_store/controller/Cart/cartController.dart';

class pedidoController {
  FirebaseFirestore _firestore;

  pedidoController(FirebaseFirestore firestore) {
    this._firestore = firestore;
  }

  Future<bool> insertPedido(Pedido pedido) async {
    await _firestore
        .collection('Pedido')
        .add({
          'carritoId': pedido.carritoId,
          'fecha': pedido.fecha,
          'instrucciones': pedido.instrucciones,
          'metodoEntrega': pedido.metodoEntrega,
          'productos': pedido.productos,
          'total': pedido.total
        })
        .then((value) => print("Pedido agregado"))
        .catchError((error) => print("Fallo inserción: $error"));

    CartController carrito = new CartController();
    await carrito.clear_cart();
    return true;
  }

  Future<List<Pedido>> get_pedido(String id) async {
    var docs =
        await _firestore.collection('Pedido').get().then((value) => value.docs);

    List<Pedido> p = [];
    for (var doc in docs) {
      Pedido temp = Pedido.fromJson(doc.data());
      if (temp.carritoId == id) {
        p.add(temp);
      }
    }

    return p;
  }
}
