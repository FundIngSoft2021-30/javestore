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

    CartController carrito = new CartController(cartID: pedido.carritoId);
    await carrito.clear_cart();
    return true;
  }
}
